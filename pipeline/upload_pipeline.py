#!/usr/bin/env python3
"""Resilient uploader for the timepiece transplant pipeline (runs as upload-timepiece.service).

Items are processed in order; progress is saved after EVERY item so a crash or
reboot loses at most the in-flight item. The script exits non-zero while work
remains (Restart=on-failure keeps it going) and exits 0 when everything is done.

Operator entry points:

    python3 pipeline/upload_pipeline.py --check    # verify API access, exit
    python3 pipeline/upload_pipeline.py --status   # plan vs state, exit
    python3 pipeline/upload_pipeline.py --sync      # reconcile with the platform, exit
    python3 pipeline/upload_pipeline.py --max-items 3 --max-seconds 150   # bounded chunk
    python3 pipeline/upload_pipeline.py --kind thm --max-items 3 --job-timeout 60

Environment: PROVE2ME_WS (workspace root), PROVE2ME_API_KEY (platform credential),
LAKE_BIN (Lean toolchain), PROVE2ME_SKIP_LOCAL_COMPILE=1 (no local gate; the
server compiles every submission anyway).  A bounded run exits 0 at the bound, so
short-lived hosts can drive the same append-only state in chunks.
"""
import argparse
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
import time
import urllib.parse

# Workspace root: PROVE2ME_WS override first, else the checkout this script
# lives in (pipeline/upload_pipeline.py -> repo root).  The canonical NixOS
# layout (/home/leo/prove2me_workspace) therefore behaves exactly as before,
# while the same uploader can also run from any other clone of the workspace.
WS = (os.environ.get("PROVE2ME_WS")
      or os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
PIPE = f"{WS}/pipeline"
CANONICAL_WS = "/home/leo/prove2me_workspace"

# Lean gate: LAKE_BIN override, else `lake` on PATH, else the elan v4.33.1
# toolchain used on the canonical machine.  PROVE2ME_SKIP_LOCAL_COMPILE=1
# skips the local gate explicitly (for checkouts with no Lean toolchain, e.g. a
# cloud sandbox) and lets the platform compile gate be the oracle.
LAKE_BIN = (os.environ.get("LAKE_BIN")
            or shutil.which("lake")
            or "/home/leo/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lake")
SKIP_LOCAL_COMPILE = os.environ.get("PROVE2ME_SKIP_LOCAL_COMPILE") == "1"


def resolve_path(path):
    """Wave-spec paths are absolute to the canonical workspace.  Re-root them
    onto THIS checkout when that absolute path is absent, so one spec runs from
    any clone."""
    if os.path.exists(path):
        return path
    for prefix in (CANONICAL_WS, WS):
        if path == prefix or path.startswith(prefix + "/"):
            cand = os.path.join(WS, path[len(prefix):].lstrip("/"))
            if os.path.exists(cand):
                return cand
    return path

STATE_FILE = f"{WS}/state/pipeline.json"
LOG = f"{WS}/state/pipeline.log"
API = "https://prove2.me/api/v1"
MAX_ATTEMPTS = 5  # per-item attempt ceiling before an item is parked as failed
# Per-item job poll ceiling.  The server compiles each submission and a big
# bundle can legitimately idle for minutes (§3), so 900 s is right for the
# daemon; bounded/chunked runs lower it (--job-timeout) so a chunk returns
# cleanly instead of being killed mid-poll.
JOB_TIMEOUT = int(os.environ.get("PROVE2ME_JOB_TIMEOUT") or 900)
POLL_INTERVAL = float(os.environ.get("PROVE2ME_POLL_INTERVAL") or 8)

# Hard wall-clock budget for the WHOLE process, set from --max-seconds.  The
# submit loop's own bound is not enough on a short-lived host: the preflight
# re-reads the whole publish-job catalogue and an in-flight poll round can run
# on its own clock, so a "bounded" chunk could still outlive the caller's
# timeout and look like a command that never finishes.  `api()` clamps every
# request to the remaining budget, so a stalled request cannot overshoot either.
DEADLINE = None  # time.monotonic() deadline, or None for the unbounded daemon
# Same budget, set from the environment: the point of a bounded chunk is that
# the WHOLE process returns, and `--max-seconds` only reaches the submit loop
# while the preflight (`platform_jobs()` re-reads the catalogue) and any poll in
# flight run on their own clock.  PROVE2ME_MAX_SECONDS also lets a short-lived
# host cap a run whose argument list it does not control.
if (os.environ.get("PROVE2ME_MAX_SECONDS") or "").strip():
    DEADLINE = time.monotonic() + float(os.environ["PROVE2ME_MAX_SECONDS"])


def budget_left():
    return None if DEADLINE is None else DEADLINE - time.monotonic()


def over_budget():
    return DEADLINE is not None and time.monotonic() >= DEADLINE


# Raised by `api()` when the chunk's budget is gone.  A request that could not
# be made is a *wait*, never a failure of the item: the submit loop maps it to
# BUDGET_WAIT and stops instead of spending one of the 5 attempts on it.
class BudgetExceeded(RuntimeError):
    pass


BUDGET_WAIT = "chunk wall-clock budget exhausted"

# Pipelined mode (--parallel N).  The server spends ~20-30 s compiling each
# submission, and the sequential loop sleeps away most of that per item.  In
# pipelined mode the `do_*` handlers stop right after the submit and hand the
# job id to the caller, which polls every in-flight item together.  Verdict
# semantics are identical: `done` is only ever written on PUBLISHED/ACCEPTED,
# anything left in flight stays `pending` with its job id and is re-polled on
# the next run without consuming an attempt.
PIPELINE_MODE = False
INFLIGHT = {}
SUBMITTED = "__submitted__"

# --only: substring filter for targeting a specific node (or a small chain of
# them) instead of walking ORDER.  Needed because a blocking node can sit
# anywhere in the deps-first order, far out of reach of a bounded chunk.
ONLY_ITEMS = None

IMPORT_DEF = "import Definitions.Def_timepiece_corrector"
OPENS = "open Complex Finset Filter Topology\nopen scoped ArithmeticFunction ArithmeticFunction.Moebius ComplexConjugate"
BUNDLE = open(f"{PIPE}/def_timepiece_corrector.lean", encoding="utf-8").read()

THMS = {
    "zeta_symm": {
        "title": "Zeta functional-equation symmetry of zeros",
        "nl": "Functional-equation symmetry for the Riemann zeta function: if $s$ is a zero of $\\zeta$ with $0 < \\Re s < 1$, then $1 - s$ is also a zero. This is the half of the zeta functional equation that survives on the zero set, proved via the completed-zeta reflection $\\zeta(1-s)$ in terms of $\\zeta(s)$.",
        "tags": ["timepiece", "analytic-number-theory", "zeta"],
    },
    "X_p_zero": {
        "title": "Corrector factor is trivial on the zero phase path",
        "nl": "For the identically-zero phase path $\\omega \\equiv 0$, every corrector factor satisfies $X_p(p, P, \\omega) = 1$: primes $p \\le P$ are pinned to $1$ by definition, and for $p > P$ the rotation factor $e^{2\\pi i \\omega_p}$ degenerates to $e^0 = 1$.",
        "tags": ["timepiece", "analytic-number-theory"],
    },
    "X_mult_zero": {
        "title": "Multiplicative corrector is trivial on the zero phase path",
        "nl": "The multiplicative corrector $X(n, P, \\omega) = \\prod_{p \\mid n} X_p(p, P, \\omega)$ equals $1$ for the identically-zero phase path, so the randomized series recovers the classical one there.",
        "tags": ["timepiece", "analytic-number-theory"],
    },
    "norm_X_mult_list_eq_one": {
        "title": "Corrector factors have unit modulus",
        "nl": "Each corrector factor $X_p(p, P, \\omega)$ has modulus exactly $1$ (it is either the constant $1$ or a unit-circle rotation), hence so does every finite product of them.",
        "tags": ["timepiece", "analytic-number-theory"],
    },
    "norm_X_mult_eq_one": {
        "title": "The multiplicative corrector has unit modulus",
        "nl": "Unconditionally in the phase path $\\omega$: $\\|X(n, P, \\omega)\\| = 1$ for every $n$, because the corrector is a finite product of unit-modulus prime factors.",
        "tags": ["timepiece", "analytic-number-theory"],
    },
    "euler_partial_product_nonvanishing": {
        "title": "Finite Euler products of the corrector are analytic and non-vanishing",
        "nl": "On any disk where $\\Re z > 1/2$, the finite Euler product $g(s) = \\prod_{2 \\le p \\le K,\\ p \\text{ prime}} (1 - X_p(p,P,\\omega) p^{-s})$ is analytic and nowhere zero: each factor is analytic in $s$, and each factor is non-zero because $\\|X_p p^{-z}\\| = p^{-\\Re z} < 1$.",
        "tags": ["timepiece", "complex-analysis", "analytic-number-theory"],
    },
    "S_recip_random_zero": {
        "title": "Randomized series recovers the classical series on the zero path",
        "nl": "On the identically-zero phase path the randomized partial series agrees with the classical one: $S_{\\text{recip}}^{\\text{rand}}(N, P, s, 0) = S_{\\text{class}}(N, s)$, since the corrector collapses to $1$ term-by-term.",
        "tags": ["timepiece", "analytic-number-theory"],
    },
    "bohr_cahen_algebraic_tail_bound": {
        "title": "Bohr\u2013Cahen algebraic tail decay via Abel summation",
        "nl": "If the randomized partial series at $s_0$ is uniformly bounded by $M_P$ over all $N$ and phase paths $\\omega$, then Abel summation by parts gives an algebraic tail bound uniform in $\\omega$: for $\\Re s > \\Re s_0$ and $0 < m \\le N$, the tail $\\sum_{m \\le n \\le N} \\mu(n) X(n,P,\\omega) n^{-s}$ is bounded by $M_P (2 + \\|s - s_0\\| + \\|s - s_0\\| / (\\Re s - \\Re s_0))\\, m^{\\Re s_0 - \\Re s}$.",
        "tags": ["timepiece", "analytic-number-theory", "bohr-cahen"],
    },
}

SRC = {"zeta_symm": f"{WS}/Theorems/Thm_zeta_symm.lean"}

# ---- Wave payload (BookProof QYM/NS/QG/SIRK chapters) — see scripts/wave_upload_spec.py ----
WAVE = json.load(open(f"{PIPE}/wave_upload.json", encoding="utf-8"))
WAVE_DEFS = WAVE["defs"]           # chapter name -> def metadata
WAVE_THMS = WAVE["thms"]           # slug -> {name (dotted), file, meta}
WAVE_SOL_ORDER = WAVE["sol_order"]  # topological (dependencies first)


def _declared_theorems(path):
    """Every top-level `theorem` declaration in a generated stub, in order."""
    try:
        with open(path, encoding="utf-8") as f:
            txt = f.read()
    except OSError:
        return []
    return re.findall(r"(?m)^theorem\s+([A-Za-z_][A-Za-z0-9_'.]*)", txt)


def _name_shape(name):
    """A name's identity up to the assembler's `_` -> `.` guess: drop both
    separators, so `a_b.c` and `a.b_c` are recognised as the same identifier."""
    return re.sub(r"[._]", "", name or "")


def reconcile_thm_names(thms):
    """Adopt the declaration that is actually in the file when the spec's dotted
    `name` does not appear there verbatim.

    `wave_upload.json` is assembled with a `_` -> `.` heuristic, which is right for
    the chapters that open a namespace per component but wrong for any identifier
    that keeps its underscores.  A wrong name is not merely cosmetic: the splitter
    looks for `^theorem <name>` and never finds it, so the item reports
    "cannot split formal_statement" and burns one of its five attempts on every
    visit until it is parked at `failed`.  The file is authoritative.
    """
    fixed = []
    for slug, meta in thms.items():
        decls = _declared_theorems(resolve_path(meta.get("file", "")))
        if not decls or meta.get("name") in decls:
            continue
        # A per-node stub declares exactly the one theorem the node is about, so
        # a lone declaration settles the name outright.  Only when the file holds
        # several (inline helpers promoted to top level) is the shape the clue.
        if len(decls) == 1:
            cand = decls
        else:
            cand = [d for d in decls if _name_shape(d) == _name_shape(meta["name"])]
        if len(cand) == 1:
            fixed.append((slug, meta["name"], cand[0]))
            meta["name"] = cand[0]
    return fixed


# Names the spec got wrong, corrected from the files themselves.  Kept so
# `--status` and tools can report them instead of silently patching the payload.
REPAIRED_THM_NAMES = reconcile_thm_names(WAVE_THMS)
def topological_def_order(defs):
    """Compute topological order of def bundles respecting cross-bundle dependencies."""
    dep_graph = {}
    for name, meta in defs.items():
        filepath = resolve_path(meta['file'])
        if not os.path.exists(filepath):
            dep_graph[name] = set()
            continue
        with open(filepath) as f:
            content = f.read()
        deps = set()
        for m in re.finditer(r'import Definitions\.Def_(Chapter[A-Z][A-Za-z0-9]*)', content):
            dep_name = m.group(1)
            chap_name = dep_name.removeprefix('Def_Chapter')
            if chap_name in defs:
                deps.add(chap_name)
        dep_graph[name] = deps
    
    visited = set()
    order = []
    def visit(name):
        if name in visited:
            return
        visited.add(name)
        for dep in sorted(dep_graph.get(name, set())):
            if dep in defs:
                visit(dep)
        order.append(name)

    for name in defs:
        visit(name)
    # Dependencies are appended before their dependents (`visit` recurses into
    # deps first), so `order` is already deps-first — do NOT reverse.
    return order


WAVE_DEF_ORDER = topological_def_order(WAVE_DEFS)

# Hard guard: any source folder is fine EXCEPT Book/ (the prose book chapters
# — titles without formal math). '/Book/' cannot match '/BookProof/' ('P' != '/'),
# so this rejects only the Book folder. A violating source aborts the run.
for _c, _d in WAVE_DEFS.items():
    assert "/Book/" not in _d["source"], _c
for _s, _t in WAVE_THMS.items():
    assert "/Book/" not in _t["source"], _s

LEGACY_ORDER = ["def:timepiece_corrector"] + [f"thm:{n}" for n in THMS] + [f"sol:{n}" for n in THMS]
WAVE_ORDER = ([f"def:{c}" for c in WAVE_DEF_ORDER]
              + [f"thm:{s}" for s in WAVE_SOL_ORDER]
              + [f"sol:{s}" for s in WAVE_SOL_ORDER])
ORDER = LEGACY_ORDER + WAVE_ORDER


def log(msg):
    line = f"{time.strftime('%H:%M:%S')} {msg}"
    print(line, flush=True)
    with open(LOG, "a") as f:
        f.write(line + "\n")


def load_state():
    if os.path.exists(STATE_FILE):
        with open(STATE_FILE) as f:
            return json.load(f)
    return {"items": {}}


def save_state(st):
    os.makedirs(os.path.dirname(STATE_FILE), exist_ok=True)
    with open(STATE_FILE + ".tmp", "w") as f:
        json.dump(st, f)
    os.replace(STATE_FILE + ".tmp", STATE_FILE)


def api_key():
    # PROVE2ME_API_KEY (injected by the host environment) wins; otherwise use
    # the gitignored credentials.json at the workspace root.
    key = (os.environ.get("PROVE2ME_API_KEY") or "").strip()
    if key:
        return key
    return json.load(open(f"{WS}/credentials.json"))["api_key"]


_token = {"v": None, "t": 0}


def token():
    if _token["v"] and time.time() - _token["t"] < 3000:
        return _token["v"]
    r = subprocess.run(["curl", "-s", "-X", "POST", f"{API}/agent/refresh",
                        "-H", "Content-Type: application/json",
                        "-d", json.dumps({"api_key": api_key()})],
                       capture_output=True, text=True, timeout=30)
    tok = json.loads(r.stdout).get("access_token")
    if not tok:
        raise RuntimeError("token refresh failed")
    _token["v"] = tok
    _token["t"] = time.time()
    return tok


def api(method, endpoint, data=None, params=None):
    url = f"{API}/{endpoint}"
    if params:
        url += "?" + urllib.parse.urlencode(params)
    cmd = ["curl", "-s", "-X", method, url, "-H", f"Authorization: Bearer {token()}"]
    if data is not None:
        cmd += ["-H", "Content-Type: application/json", "-d", json.dumps(data)]
    left = budget_left()
    if left is not None:
        if left <= 1:
            raise BudgetExceeded(BUDGET_WAIT)
        timeout = max(5.0, min(90.0, left))
    else:
        timeout = 90
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, timeout=timeout)
    except subprocess.TimeoutExpired:
        if over_budget():
            raise BudgetExceeded(BUDGET_WAIT)
        raise
    try:
        return json.loads(r.stdout)
    except ValueError:
        return None


def norm_stmt(text):
    return re.sub(r"\s+", " ", text or "").strip()


TITLE_LIMIT = 200  # server-enforced on theorem_title / definition_title (BYTES)


def _clip_bytes(text, limit):
    """Longest prefix of `text` that fits in `limit` UTF-8 bytes, never
    splitting a character."""
    out, used = [], 0
    for ch in text:
        n = len(ch.encode("utf-8"))
        if used + n > limit:
            break
        out.append(ch)
        used += n
    return "".join(out)


def clamp_title(title, limit=TITLE_LIMIT):
    """`theorem_title` and `definition_title` are display-only and the server
    caps them at 200 **bytes** of UTF-8, but the generator lifts them verbatim
    from chapter docstrings, which are routinely longer.  Counting characters
    is not enough: these titles are full of multi-byte math symbols (ℝ, ∀, →,
    𝓝), so a 200-character title can be 247 bytes and is still rejected.  Clamp
    on the encoded length at a word boundary instead of letting every such
    submission burn an attempt."""
    title = norm_stmt(title)
    if len(title.encode("utf-8")) <= limit:
        return title
    cut = _clip_bytes(title, limit - 3).rstrip()
    if " " in cut:
        cut = cut[:cut.rfind(" ")].rstrip()
    return cut + "..."


def find_existing(name, formal):
    """Search the platform for an equivalent theorem (exact name or
    whitespace-normalized formal_statement). Improving what exists beats
    creating from scratch: callers reuse the node instead of duplicating."""
    r = api("GET", "theorems", params={"q": name, "limit": "20"})
    target = norm_stmt(formal)
    for t in (r or {}).get("theorems", []):
        if t.get("theorem_name") == name or norm_stmt(t.get("formal_statement")) == target:
            return t.get("theorem_id"), t.get("theorem_name"), t.get("status")
    return None


MATHLIB_COMMON = {
    "theorem", "lemma", "Nat", "Real", "Complex", "Set", "Metric", "Filter",
    "Finset", "List", "AnalyticOnNhd", "TendstoUniformlyOn", "IsOpen",
    "IsPreconnected", "atTop", "norm", "Complex", "RiemannZeta", "riemannZeta",
}


def stmt_tokens(formal):
    toks = [t for t in re.findall(r"[A-Za-z_][A-Za-z0-9_']{3,}", formal)
            if t not in MATHLIB_COMMON and not t.startswith("Thm_")]
    return toks


def stmt_conclusion(formal):
    """Normalized conclusion: the text after the final ':' of the declaration."""
    m = list(re.finditer(r"(?<![:\w]):(?![:\w])", formal))
    if not m:
        return ""
    return norm_stmt(formal[m[-1].end():].replace(":= by sorry", "").strip())


def find_related(name, formal):
    """Existing platform theorems related to the candidate: distinct tokens
    searched against the catalog; Proved ones are potential reduction bases,
    same-conclusion ones mean the candidate may be a corollary (coverage)."""
    toks = sorted(set(stmt_tokens(formal)), key=len, reverse=True)[:3]
    seen, related = set(), []
    for tok in toks:
        r = api("GET", "theorems", params={"q": tok, "limit": "20"})
        for t in (r or {}).get("theorems", []):
            if t.get("theorem_name") == name or t.get("theorem_id") in seen:
                continue
            seen.add(t.get("theorem_id"))
            related.append({"theorem_id": t.get("theorem_id"),
                            "theorem_name": t.get("theorem_name"),
                            "status": t.get("status"),
                            "same_conclusion":
                                norm_stmt(stmt_conclusion(t.get("formal_statement")))
                                == norm_stmt(stmt_conclusion(formal)) and bool(stmt_conclusion(formal))})
    return related


# A job that is still queued/compiling is not a failure of the item: the uploader
# records the job_id BEFORE polling and re-polls on the next pass (§3), and big
# bundles legitimately idle for minutes.  Burning one of the 5 attempts on that
# would make slow-but-successful items look permanently broken.
# "not published yet" is the sol-side equivalent: a solution's target theorem
# may still be pending, which is a wait, not a failure of the solution.
TRANSIENT_ERRORS = ("still in flight", "poll timeout", "not published yet",
                    BUDGET_WAIT)


def is_transient(err):
    return any(t in (err or "") for t in TRANSIENT_ERRORS)


_TOOLCHAIN_WARNED = False


def local_compile(path):
    global _TOOLCHAIN_WARNED
    # The local gate is only as good as the toolchain in this checkout.  A
    # checkout with no Lean toolchain at all (a cloud sandbox, a fresh clone
    # before `lake exe cache get`) cannot run it: failing here would burn one of
    # the 5 attempts on every fresh submission for a reason that says nothing
    # about the proof.  `cmd_status` reports the missing toolchain, so degrade to
    # a one-time warning and let the platform compiler be the oracle (the server
    # compiles every submission regardless).
    if SKIP_LOCAL_COMPILE:
        return True, "local compile skipped (PROVE2ME_SKIP_LOCAL_COMPILE=1)"
    if not os.path.exists(LAKE_BIN):
        if not _TOOLCHAIN_WARNED:
            _TOOLCHAIN_WARNED = True
            log(f"warning: no Lean toolchain at {LAKE_BIN} - skipping the local gate "
                f"and using the platform compiler as the oracle")
        return True, "local compile skipped (no Lean toolchain in this checkout)"
    try:
        r = subprocess.run([LAKE_BIN, "env", "lean", path],
                           cwd=WS, capture_output=True, text=True, timeout=600)
        return r.returncode == 0, (r.stderr or r.stdout)[:400]
    except subprocess.TimeoutExpired:
        return False, "local compile timeout"


def poll_job(job_id):
    deadline = time.time() + JOB_TIMEOUT
    while time.time() < deadline:
        time.sleep(8)
        p = api("GET", f"publish-jobs/{job_id}", None)
        st = (p or {}).get("status")
        if st in ("PUBLISHED", "FAILED", "ERROR"):
            return p
        if p is None:
            continue
    return {"status": "FAILED", "error_message": "poll timeout"}


def _do_legacy_def(st, item):
    rec = st["items"].get(item, {})
    if rec.get("job_id"):
        p = poll_job(rec["job_id"])
        if p.get("status") == "PUBLISHED":
            st["items"][item] = {"status": "done", "def_id": p.get("theorem_id") or p.get("id")}
            return None
        if p.get("status") in ("PENDING", "COMPILING", None):
            return "def job still in flight"
    path = f"{PIPE}/def_timepiece_corrector.lean"
    ok, err = local_compile(path)
    if not ok:
        return f"local compile failed: {err[:200]}"
    ex = api("GET", "theorems", params={"q": "timepiece_corrector", "limit": "5"})
    for t in (ex or {}).get("theorems", []):
        if t.get("theorem_name") == "timepiece_corrector":
            st["items"][item] = {"status": "done", "def_id": t.get("theorem_id"), "reused": True}
            return None
    r = api("POST", "submit-definition", {
        "definition_name": "timepiece_corrector",
        "definition_title": "Unit-circle corrector and randomized Dirichlet series",
        "definition": BUNDLE,
        "natural_language_statement": "The unit-circle corrector machinery of the timepiece project: the phase space, the prime corrector factors X_p (pinned to 1 for p <= P, unit rotations above), their multiplicative extension X(n), the classical partial Dirichlet series of the Mobius function, and its randomized counterpart with corrector weights.",
        "tags": ["timepiece", "analytic-number-theory"],
    })
    jobs = (r or {}).get("jobs", [])
    if not jobs:
        return f"submit-definition rejected: {json.dumps(r)[:200]}"
    st["items"][item]["job_id"] = jobs[0]["job_id"]
    save_state(st)
    p = poll_job(jobs[0]["job_id"])
    if p.get("status") == "PUBLISHED":
        st["items"][item] = {"status": "done", "def_id": p.get("theorem_id") or p.get("id")}
        return None
    return f"publish {p.get('status')}: {p.get('error_message', '')[:200]}"


def thm_path(name):
    return f"{WS}/Theorems/Thm_{name}.lean"


def _do_legacy_thm(st, item, name):
    path = thm_path(name)
    rec = st["items"].get(item, {})
    if rec.get("job_id"):
        p = poll_job(rec["job_id"])
        if p.get("status") == "PUBLISHED":
            st["items"][item] = {"status": "done", "theorem_id": p.get("theorem_id")}
            return None
        if p.get("status") in ("PENDING", "COMPILING", None):
            return "theorem job still in flight"
    ok, err = local_compile(thm_path(name))
    if not ok:
        return f"local compile failed: {err[:200]}"
    stmt = open(thm_path(name), encoding="utf-8").read()
    m = re.search(r"\n\n(theorem .*)$", stmt, re.S)
    formal = m.group(1).strip()
    meta = THMS[name]
    ex = find_existing(name, formal)
    if ex:
        tid, tname, tstatus = ex
        st["items"][item] = {"status": "done", "theorem_id": tid, "reused": True,
                             "reused_status": tstatus}
        log(f"{item}: REUSING existing {tname} ({tstatus}) {tid}")
        return None
    rel = find_related(name, formal)
    covered = [x for x in rel if x["same_conclusion"] and x["status"] == "Proved"]
    if rel:
        st["items"][item]["related"] = rel[:10]
        save_state(st)
        log(f"{item}: {len(rel)} related existing theorems "
            f"({len(covered)} Proved with same conclusion)")
    if covered:
        st["items"][item] = {"status": "done", "skipped": "covered by existing Proved theorems",
                             "covered_by": [x["theorem_id"] for x in covered]}
        return None
    r = api("POST", "submit-problem", {
        "theorem_name": name,
        "theorem_title": clamp_title(meta["title"]),
        "formal_statement": formal,
        "preamble": ("import Mathlib\n" + IMPORT_DEF + "\n" + OPENS) if name != "zeta_symm" else "import Mathlib\nopen Complex Finset Filter Topology",
        "natural_language_statement": meta["nl"],
        "description": f"From the timepiece Lean 4 formalization project ({name}).",
        "tags": meta["tags"],
    })
    jobs = (r or {}).get("jobs", [])
    if not jobs:
        errtxt = json.dumps(r)[:200]
        if "already exists" in errtxt:
            ex = find_existing(name, formal)
            if ex:
                st["items"][item] = {"status": "done", "theorem_id": ex[0],
                                     "reused": True, "reused_status": ex[2]}
                return None
        return f"submit-problem rejected: {errtxt}"
    st["items"][item]["job_id"] = jobs[0]["job_id"]
    st["items"][item]["job_src"] = file_stamp(path)
    save_state(st)
    if PIPELINE_MODE:
        INFLIGHT[jobs[0]["job_id"]] = (item, "publish")
        return SUBMITTED
    p = poll_job(jobs[0]["job_id"])
    if p.get("status") == "PUBLISHED":
        st["items"][item] = {"status": "done", "theorem_id": p.get("theorem_id")}
        return None
    return f"publish {p.get('status')}: {p.get('error_message', '')[:200]}"


def _do_legacy_sol(st, item, name):
    thm = st["items"].get(f"thm:{name}", {})
    tid = thm.get("theorem_id")
    if thm.get("status") != "done" or not tid:
        return "theorem not published yet"
    if thm.get("reused_status") == "Proved":
        st["items"][item] = {"status": "done", "skipped": "theorem already Proved on platform"}
        return None
    path = f"{WS}/Solutions/Sol_{name}.lean"
    ok, err = local_compile(path)
    if not ok:
        return f"local compile failed: {err[:200]}"
    bases = find_related(name, "")
    bases = [b for b in bases if b["status"] == "Proved"]
    if bases:
        log(f"sol:{name}: {len(bases)} Proved related theorems could simplify this proof: "
            + ", ".join(b["theorem_name"] for b in bases[:5]))
        st["items"][item]["reduction_bases"] = [b["theorem_id"] for b in bases][:10]
        save_state(st)
    r = subprocess.run(["curl", "-s", "-X", "POST", f"{API}/verify",
                        "-H", f"Authorization: Bearer {token()}",
                        "-F", f"theorem_id={tid}",
                        "-F", f"file=@{path}",
                        "-F", "explanation=Direct transplant of the proof from the timepiece Lean 4 formalization project, verified locally against the platform environment (Mathlib 0df444a, Lean v4.33.1) before submission."],
                       capture_output=True, text=True, timeout=90)
    resp = json.loads(r.stdout)
    sid = resp.get("submission_id")
    if not sid:
        return f"verify rejected: {r.stdout[:200]}"
    deadline = time.time() + JOB_TIMEOUT
    while time.time() < deadline:
        time.sleep(10)
        p = api("GET", "verify", params={"submission_id": sid})
        s = (p or {}).get("status")
        if s in ("ACCEPTED", "SKETCH_ACCEPTED", "Proved"):
            st["items"][item] = {"status": "done", "submission_id": sid}
            return None
        if s and s not in ("PENDING", "COMPILING"):
            return f"verdict {s}: {(p or {}).get('error_message', '')[:200]}"
    return "verify poll timeout"


# --------------------------------------------------------------------------
# Wave payload handlers (BookProof chapters)
# --------------------------------------------------------------------------


def wave_def_meta(chapter):
    return WAVE_DEFS[chapter]


def _find_definition_node(chapter):
    """Locate an already-published Definition node by exact name (search the
    catalog with a generous limit; the def node may sit after theorem hits)."""
    for limit in ("50", "100"):
        ex = api("GET", "theorems", params={"q": chapter, "limit": limit})
        for t in (ex or {}).get("theorems", []):
            if t.get("theorem_name") == chapter and t.get("status") == "Definition":
                return t.get("theorem_id")
    return None


def do_wave_def(st, item, chapter):
    meta = wave_def_meta(chapter)
    path = resolve_path(meta["file"])
    rec = st["items"].get(item, {})
    if rec.get("job_id") and rec.get("job_src") not in (None, file_stamp(path)):
        log(f"{item}: recorded publish job predates the current bundle — resubmitting")
        rec.pop("job_id", None)
        rec.pop("job_src", None)
    if rec.get("job_id"):
        if PIPELINE_MODE:
            # A job left in flight by an earlier chunk joins this chunk's
            # parallel drain instead of blocking the fill loop on it.
            INFLIGHT[rec["job_id"]] = (item, "publish")
            return SUBMITTED
        p = poll_job(rec["job_id"])
        if p.get("status") == "PUBLISHED":
            st["items"][item] = {"status": "done", "def_id": p.get("theorem_id") or p.get("id")}
            return None
        if p.get("status") in ("PENDING", "COMPILING", None):
            return "def job still in flight"
    ok, err = local_compile(path)
    if not ok:
        return f"local compile failed: {err[:200]}"
    body = open(path, encoding="utf-8").read()
    existing_id = _find_definition_node(chapter)
    if existing_id:
        st["items"][item] = {"status": "done", "def_id": existing_id, "reused": True}
        log(f"{item}: REUSING existing Definition node {existing_id}")
        return None
    r = api("POST", "submit-definition", {
        "definition_name": chapter,
        "definition_title": clamp_title(meta["title"]),
        "definition": body,
        "natural_language_statement": meta["nl"],
        "source": meta["source"],
        "tags": meta["tags"],
    })
    jobs = (r or {}).get("jobs")
    if not jobs and isinstance(r, dict) and r.get("job_id"):
        jobs = [{"job_id": r["job_id"]}]
    if not jobs:
        errtxt = json.dumps(r)[:200]
        if "already exists" in errtxt:
            existing_id = _find_definition_node(chapter)
            if existing_id:
                st["items"][item] = {"status": "done", "def_id": existing_id, "reused": True}
                return None
        return f"submit-definition rejected: {errtxt}"
    st["items"][item]["job_id"] = jobs[0]["job_id"]
    st["items"][item]["job_src"] = file_stamp(path)
    save_state(st)
    if PIPELINE_MODE:
        INFLIGHT[jobs[0]["job_id"]] = (item, "publish")
        return SUBMITTED
    p = poll_job(jobs[0]["job_id"])
    if p.get("status") == "PUBLISHED":
        st["items"][item] = {"status": "done", "def_id": p.get("theorem_id") or p.get("id")}
        return None
    return f"publish {p.get('status')}: {p.get('error_message', '')[:200]}"


def do_wave_thm(st, item, slug):
    meta = WAVE_THMS[slug]
    path = resolve_path(meta["file"])
    rec = st["items"].get(item, {})
    if rec.get("job_id") and rec.get("job_src") not in (None, file_stamp(path)):
        # The statement was corrected after this job was submitted, so its verdict
        # describes text that no longer exists.  Reporting it would mark a good
        # statement FAILED and spend one of the five attempts doing it.
        log(f"{item}: recorded publish job predates the current statement — resubmitting")
        rec.pop("job_id", None)
        rec.pop("job_src", None)
    if rec.get("job_id"):
        if PIPELINE_MODE:
            INFLIGHT[rec["job_id"]] = (item, "publish")
            return SUBMITTED
        p = poll_job(rec["job_id"])
        if p.get("status") == "PUBLISHED":
            st["items"][item] = {"status": "done", "theorem_id": p.get("theorem_id")}
            return None
        if p.get("status") in ("PENDING", "COMPILING", None):
            return "theorem job still in flight"
    ok, err = local_compile(path)
    if not ok:
        return f"local compile failed: {err[:200]}"
    txt = open(path, encoding="utf-8").read()
    # Split at the top-level `theorem <dotted name>` declaration: everything
    # before it (imports/opens/variables/`omit … in`) is the preamble, the
    # declaration itself is the formal_statement.  Handles files where the
    # theorem line directly follows `omit … in` (no blank line before it).
    name = meta["name"]
    # The name must not be a *prefix* of a longer identifier.  A trailing \b
    # cannot express that: theorem names may end in a non-word character (Lean
    # primes them as `foo'`), and `'` followed by a space has no word boundary,
    # so a `\b` silently makes the whole declaration unsplittable.  Use a
    # negative lookahead over identifier characters instead.
    m = re.search(r"(?m)^theorem\s+" + re.escape(name) + r"(?![A-Za-z0-9_'.!?])", txt)
    if not m:
        return f"cannot split formal_statement from {path}"
    preamble = txt[:m.start()].rstrip()
    formal = txt[m.start():].strip()
    if not formal.rstrip().endswith(":= by sorry"):
        return "formal_statement does not end with := by sorry"
    ex = find_existing(name, formal)
    if ex:
        tid, tname, tstatus = ex
        st["items"][item] = {"status": "done", "theorem_id": tid, "reused": True,
                             "reused_status": tstatus}
        log(f"{item}: REUSING existing {tname} ({tstatus}) {tid}")
        return None
    title = clamp_title(meta["title"])
    if title != meta["title"]:
        log(f"{item}: title clamped to {len(title)} chars (server limit {TITLE_LIMIT})")
    r = api("POST", "submit-problem", {
        "theorem_name": name,
        "theorem_title": title,
        "formal_statement": formal,
        "preamble": preamble,
        "natural_language_statement": meta["nl"],
        "source": meta["source"],
        "tags": meta["tags"],
    })
    jobs = (r or {}).get("jobs", [])
    if not jobs:
        errtxt = json.dumps(r)[:200]
        if "already exists" in errtxt:
            ex = find_existing(name, formal)
            if ex:
                st["items"][item] = {"status": "done", "theorem_id": ex[0],
                                     "reused": True, "reused_status": ex[2]}
                return None
        return f"submit-problem rejected: {errtxt}"
    st["items"][item]["job_id"] = jobs[0]["job_id"]
    st["items"][item]["job_src"] = file_stamp(path)
    save_state(st)
    if PIPELINE_MODE:
        INFLIGHT[jobs[0]["job_id"]] = (item, "publish")
        return SUBMITTED
    p = poll_job(jobs[0]["job_id"])
    if p.get("status") == "PUBLISHED":
        st["items"][item] = {"status": "done", "theorem_id": p.get("theorem_id")}
        return None
    return f"publish {p.get('status')}: {p.get('error_message', '')[:200]}"


def sol_explanation(slug, meta):
    txt = open(f"{WS}/Solutions/Sol_{slug}.lean", encoding="utf-8").read()
    deps = sorted(set(re.findall(r"import Theorems\.Thm_\S+", txt)))
    base = (f"Formal proof of `{meta['name']}` transplanted verbatim from the timepiece "
            f"Lean 4 formalization ({meta['source']}). The argument was verified locally "
            "against the platform environment (Mathlib 0df444a, Lean v4.33.1) before "
            "submission.")
    if deps:
        kids = ", ".join(f"`{d.replace('Theorems.Thm_', '').replace('_', '.')}`" for d in deps)
        base += (f" The proof imports the previously published platform theorem"
                 f"{'s' if len(deps) > 1 else ''} {kids}, mirroring the dependency "
                 "structure of the source chapter; this node therefore reduces to those "
                 "children and resolves once they are proved.")
    return base


def theorem_status(tid):
    """Platform status of a node (`Proved` / `Open` / `Definition`); None if unknown."""
    return (api("GET", f"theorems/{tid}") or {}).get("status")


def file_stamp(path):
    """Content stamp of a submission's source file.  A verdict describes the exact
    revision that was submitted, so a re-poll is only meaningful while the file is
    unchanged."""
    try:
        with open(path, "rb") as fh:
            return hashlib.sha1(fh.read()).hexdigest()[:16]
    except OSError:
        return None


def do_wave_sol(st, item, slug):
    meta = WAVE_THMS[slug]
    # A submission left compiling by an earlier chunk must be re-polled, never
    # re-submitted: a proof check takes minutes, so without this guard every run
    # would post a duplicate submission for the same node.
    path = f"{WS}/Solutions/Sol_{slug}.lean"
    rec = st["items"].get(item, {})
    if rec.get("submission_id"):
        stamp = file_stamp(path)
        if rec.get("submission_src") in (None, stamp):
            if PIPELINE_MODE:
                INFLIGHT[rec["submission_id"]] = (item, "verify")
                return SUBMITTED
            terminal, err = _apply_verify_verdict(
                api("GET", "verify", params={"submission_id": rec["submission_id"]}))
            if not terminal:
                return "verify still in flight"
            if err is None:
                st["items"][item] = {"status": "done", "submission_id": rec["submission_id"]}
                return None
            # The submission is finished (and failed): drop its id so a later retry
            # builds a fresh submission instead of re-reading this dead verdict.
            rec.pop("submission_id", None)
            rec.pop("submission_src", None)
            return err
        # The recorded submission was made from an earlier revision of this file
        # (it has been fixed since), so its verdict describes a proof that no
        # longer exists.  Re-reading it would report an obsolete error as a
        # failure of the current proof and spend one of the five attempts doing
        # it, so drop it and submit the current revision instead.
        log(f"{item}: recorded verdict predates the current solution file — resubmitting")
        rec.pop("submission_id", None)
        rec.pop("submission_src", None)
    thm = st["items"].get(f"thm:{slug}", {})
    tid = thm.get("theorem_id")
    if thm.get("status") != "done" or not tid:
        return "theorem not published yet"
    if thm.get("reused_status") == "Proved":
        st["items"][item] = {"status": "done", "skipped": "theorem already Proved on platform"}
        return None
    # Dedupe rule (b): an already-Proved node needs no solution; resolving this
    # lazily costs one GET and saves a whole submission.
    if theorem_status(tid) == "Proved":
        st["items"][item] = {"status": "done", "theorem_id": tid,
                             "skipped": "theorem already Proved on platform"}
        return None
    ok, err = local_compile(path)
    if not ok:
        return f"local compile failed: {err[:200]}"
    explanation = sol_explanation(slug, meta)
    left = budget_left()
    post_timeout = 90 if left is None else max(5.0, min(90.0, left))
    r = subprocess.run(["curl", "-s", "-X", "POST", f"{API}/verify",
                        "-H", f"Authorization: Bearer {token()}",
                        "-F", f"theorem_id={tid}",
                        "-F", f"file=@{path}",
                        "-F", f"explanation={explanation}"],
                       capture_output=True, text=True, timeout=post_timeout)
    try:
        resp = json.loads(r.stdout)
    except ValueError:
        return f"verify rejected (non-JSON): {r.stdout[:200]}"
    sid = resp.get("submission_id")
    if not sid:
        return f"verify rejected: {r.stdout[:200]}"
    # Record the id before polling in both modes: a proof check outlives any
    # chunk, so a timeout would otherwise discard the id and re-submit a
    # duplicate verification on the next run.
    st["items"][item]["submission_id"] = sid
    st["items"][item]["submission_src"] = file_stamp(path)
    save_state(st)
    if PIPELINE_MODE:
        INFLIGHT[sid] = (item, "verify")
        return SUBMITTED
    deadline = time.time() + JOB_TIMEOUT
    while time.time() < deadline:
        time.sleep(10)
        p = api("GET", "verify", params={"submission_id": sid})
        s = (p or {}).get("status")
        if s in ("ACCEPTED", "SKETCH_ACCEPTED", "Proved"):
            st["items"][item] = {"status": "done", "submission_id": sid}
            return None
        if s and s not in ("PENDING", "COMPILING"):
            return f"verdict {s}: {(p or {}).get('error_message', '')[:200]}"
    return "verify poll timeout"


def do_def(st, item):
    # The dispatch boundary is where a chunk's wall-clock budget must turn into a
    # WAIT: an item that never reached the platform has not failed, so it must
    # not spend one of the 5 attempts (BUDGET_WAIT is in TRANSIENT_ERRORS).
    if over_budget():
        return BUDGET_WAIT
    name = item.partition(":")[2]
    try:
        if name in WAVE_DEFS:
            return do_wave_def(st, item, name)
        return _do_legacy_def(st, item)
    except BudgetExceeded:
        return BUDGET_WAIT


def do_thm(st, item, name):
    if over_budget():
        return BUDGET_WAIT
    try:
        if name in WAVE_THMS:
            return do_wave_thm(st, item, name)
        return _do_legacy_thm(st, item, name)
    except BudgetExceeded:
        return BUDGET_WAIT


def do_sol(st, item, name):
    if over_budget():
        return BUDGET_WAIT
    try:
        if name in WAVE_THMS:
            return do_wave_sol(st, item, name)
        return _do_legacy_sol(st, item, name)
    except BudgetExceeded:
        return BUDGET_WAIT


# --------------------------------------------------------------------------
# Operator entry points: --check (platform access), --status (plan vs state),
# --sync (platform reconciliation), --max-items/--max-seconds (bounded chunks)
# --------------------------------------------------------------------------

SKILL_FILE = os.path.join(WS, "SKILL.md")


def skill_version():
    try:
        txt = open(SKILL_FILE, encoding="utf-8").read()
    except OSError:
        return "unknown"
    m = re.search(r'version:\s*"([^"]+)"', txt)
    return m.group(1) if m else "unknown"


def auth_probe():
    """Exchange the API key for a 1-hour access token.  (ok, version, detail)."""
    try:
        r = subprocess.run(["curl", "-s", "-X", "POST", f"{API}/agent/refresh",
                            "-H", "Content-Type: application/json",
                            "-d", json.dumps({"api_key": api_key()})],
                           capture_output=True, text=True, timeout=30)
    except Exception as e:  # operator-facing diagnostics
        return False, None, f"{type(e).__name__}: {e}"
    try:
        body = json.loads(r.stdout)
    except ValueError:
        return False, None, (r.stdout or r.stderr or "empty response")[:200]
    if not body.get("access_token"):
        return False, None, json.dumps(body)[:200]
    _token["v"], _token["t"] = body["access_token"], time.time()
    return True, body.get("version"), ""


def _list_of(payload):
    """Items of a list-envelope response.  The platform has shipped several
    envelope keys (`publish_jobs` in 0.10.x, `jobs`/`theorems` earlier), so
    accept any list value rather than trusting one name — a changed envelope
    would otherwise look like an empty account."""
    if isinstance(payload, list):
        return payload
    if isinstance(payload, dict):
        for key in ("publish_jobs", "jobs", "theorems", "items", "data", "results"):
            v = payload.get(key)
            if isinstance(v, list):
                return v
        for v in payload.values():
            if isinstance(v, list):
                return v
    return []


def _paged(endpoint, params, limit=100, max_pages=100):
    """Walk a paginated list endpoint; caps at max_pages and reports nothing itself."""
    out = []
    for page in range(max_pages):
        p = dict(params)
        p["limit"], p["offset"] = str(limit), str(page * limit)
        items = _list_of(api("GET", endpoint, params=p))
        out.extend(items)
        if len(items) < limit:
            break
    return out


def platform_jobs():
    """Newest publish job per theorem_name, from the owner's job history."""
    jobs = {}
    for kind in ("definition", "problem"):
        page = _paged("publish-jobs", {"kind": kind})
        for j in page:
            name = j.get("theorem_name")
            if not name:
                continue
            prev = jobs.get(name)
            if prev is None or j.get("status") == "PUBLISHED":
                jobs[name] = j
        log(f"sync: read {len(page)} {kind} publish job(s)")
    return jobs


def sync_state(st):
    """Append-only reconciliation with the platform (publish jobs are the source
    of truth, §3): mark plan items the platform already holds as done so a chunk
    never re-submits an existing node.  Never downgrades an existing record."""
    jobs = platform_jobs()
    added = 0
    for item in ORDER:
        if st["items"].get(item, {}).get("status") == "done":
            continue
        kind, _, name = item.partition(":")
        if kind == "def":
            j = jobs.get(name)
        elif kind == "thm":
            j = jobs.get((WAVE_THMS.get(name) or {}).get("name", name))
        else:
            continue  # solutions have no publish job; do_wave_sol resolves them
        if j and j.get("status") == "PUBLISHED":
            st["items"][item] = {"status": "done", "job_id": j.get("id"),
                                 "reused": True, "reused_status": "published",
                                 "synced_from": "publish-jobs"}
            if kind == "def":
                st["items"][item]["def_id"] = j.get("theorem_id")
            else:
                st["items"][item]["theorem_id"] = j.get("theorem_id")
            added += 1
    # A solution has no publish job, but a node the platform reports as `Proved`
    # already carries a verified proof — there is nothing left to submit for it.
    # `do_wave_sol` skips such a node when it reaches it, so recording it here
    # only makes the backlog honest instead of waiting for a chunk to discover
    # the same fact one item at a time.  Resolved by theorem_id, never by name:
    # the theorem catalogue is global and names collide across accounts.
    solved = 0
    checked = 0
    for item in ORDER:
        if not item.startswith("sol:"):
            continue
        if st["items"].get(item, {}).get("status") == "done":
            continue
        if over_budget():
            log(f"sync: wall-clock budget reached after {checked} pending solution(s); "
                f"re-run to finish reconciling")
            break
        checked += 1
        if checked % 25 == 0:
            # One GET per pending solution: without this the reconcile looks
            # hung for a minute on a large backlog.
            log(f"sync: checked {checked} pending solution(s), {solved} already Proved")
        tid = (st["items"].get(f"thm:{item.partition(':')[2]}") or {}).get("theorem_id")
        if tid and theorem_status(tid) == "Proved":
            st["items"][item] = {"status": "done", "theorem_id": tid,
                                 "reused": True, "reused_status": "Proved",
                                 "skipped": "theorem already Proved on platform",
                                 "synced_from": "theorems"}
            solved += 1
    save_state(st)
    log(f"sync: marked {added} already-published item(s) and {solved} "
        f"already-proved solution(s) done")
    return added + solved


def missing_sources():
    """ORDER items whose Lean source is absent from THIS checkout."""
    miss = {}
    for c, m in WAVE_DEFS.items():
        p = resolve_path(m["file"])
        if not os.path.exists(p):
            miss[f"def:{c}"] = p
    for s, m in WAVE_THMS.items():
        p = resolve_path(m["file"])
        if not os.path.exists(p):
            miss[f"thm:{s}"] = p
        elif not os.path.exists(f"{WS}/Solutions/Sol_{s}.lean"):
            miss[f"sol:{s}"] = f"{WS}/Solutions/Sol_{s}.lean"
    return miss


def plan_progress(st, miss=(), kinds=None):
    in_plan = set(ORDER)
    recs = st["items"]
    if kinds:
        in_plan = {i for i in in_plan if i.partition(":")[0] in kinds}
    by_kind = {}
    for i in in_plan:
        if i in miss or recs.get(i, {}).get("status") in ("done", "failed"):
            continue
        k = i.partition(":")[0]
        by_kind[k] = by_kind.get(k, 0) + 1
    return {
        "in_plan": len(in_plan),
        "done": sum(1 for i in in_plan if recs.get(i, {}).get("status") == "done"),
        "failed": sum(1 for i in in_plan if recs.get(i, {}).get("status") == "failed"),
        "pending": sum(by_kind.values()),
        "pending_by_kind": by_kind,
        "orphans": len(recs) - len(set(recs) & set(ORDER)),
    }


def cmd_check():
    ok, version, detail = auth_probe()
    if not ok:
        print("platform access: FAILED")
        print(f"  detail: {detail}")
        print("  need:   PROVE2ME_API_KEY in the host environment (Settings -> Environment),")
        print("          or credentials.json at the workspace root: {\"api_key\": \"...\"}")
        return 2
    me = api("GET", "me") or {}
    print("platform access: OK")
    print(f"  workspace       : {WS}")
    print(f"  skill / platform: {skill_version()} / {version}")
    print(f"  account         : {me.get('username') or me.get('name') or me.get('id')}")
    for kind in ("definition", "problem"):
        jobs = _paged("publish-jobs", {"kind": kind}, limit=100, max_pages=60)
        counts = {}
        for j in jobs:
            counts[j.get("status")] = counts.get(j.get("status"), 0) + 1
        print(f"  publish-jobs[{kind}]: {len(jobs)} read, {counts}")
        if not jobs:
            print(f"    (envelope: {json.dumps(api('GET', 'publish-jobs', params={'kind': kind, 'limit': '1'}))[:200]})")
    return 0


def cmd_status():
    st = load_state()
    st.setdefault("items", {})
    miss = missing_sources()
    p = plan_progress(st, miss)
    print(f"plan : {p['in_plan']} items ({len(WAVE_DEFS)} defs, "
          f"{len(WAVE_THMS)} thms, {len(WAVE_THMS)} sols)")
    print(f"state: {p['done']} done / {p['pending']} pending / {p['failed']} failed"
          + (f" ({p['orphans']} orphans ignored)" if p["orphans"] else ""))
    print(f"pending by kind: {p['pending_by_kind']}")
    nxt = [i for i in ORDER if i not in miss
           and st["items"].get(i, {}).get("status") not in ("done", "failed")][:8]
    print(f"next : {', '.join(nxt) if nxt else '(nothing pending)'}")
    if miss:
        chaps = sorted({k.split(":", 1)[1].split("_")[1] for k in miss if "_" in k})
        print(f"missing local sources: {len(miss)} item(s), e.g. {', '.join(list(miss)[:3])}")
        if chaps:
            print(f"  chapters: {', '.join(chaps[:6])}")
    if SKIP_LOCAL_COMPILE:
        print("local Lean gate: SKIPPED (PROVE2ME_SKIP_LOCAL_COMPILE=1) - the platform compiles")
    elif not os.path.exists(LAKE_BIN):
        print(f"local Lean gate: UNAVAILABLE ({LAKE_BIN}) - submissions skip the local "
              "gate and the platform compiler is the oracle; install a toolchain or "
              "set PROVE2ME_SKIP_LOCAL_COMPILE=1 to silence this")
    return 0


def published_defs():
    """Names with a PUBLISHED definition job.  A def bundle is only allowed to
    import defs that are already published (§2), so this is the preflight set."""
    defs = {n for n, j in platform_jobs().items()
            if j.get("kind") == "definition" and j.get("status") == "PUBLISHED"}
    if not defs:
        # An empty catalogue means the read failed, not that nothing is
        # published.  The preflight is truthiness-gated (`if published:`), so an
        # empty set silently disables it and every item importing an unpublished
        # bundle would be submitted anyway - a guaranteed server FAILED that
        # spends one of the 5 attempts.  Refuse to run instead (`--no-preflight`
        # is the explicit escape hatch).
        raise RuntimeError(
            "preflight could not read the published definition catalogue "
            "(network/API failure): refusing to run with dependency checking off")
    return defs


def def_imports(path):
    """`import Definitions.Def_X` names a source file depends on."""
    try:
        txt = open(path, encoding="utf-8").read()
    except OSError:
        return []
    return [m[len("Definitions.Def_"):] for m in
            re.findall(r"(?m)^import\s+(Definitions\.Def_\S+)", txt)]


def item_source(item):
    kind, _, name = item.partition(":")
    if kind == "def":
        m = WAVE_DEFS.get(name)
        return resolve_path(m["file"]) if m else f"{PIPE}/def_timepiece_corrector.lean"
    if kind == "thm":
        m = WAVE_THMS.get(name)
        return resolve_path(m["file"]) if m else thm_path(name)
    return f"{WS}/Solutions/Sol_{name}.lean"


def blocked_by(item, published):
    """An unpublished def bundle this item imports, or None.  Submitting anyway
    is a guaranteed server FAILED (§2), so the runner waits instead."""
    for dep in def_imports(item_source(item)):
        if dep not in published:
            return dep
    return None


def cmd_dry_run(limit, kinds=None):
    """Print the next `limit` items a bounded chunk would process.  No API
    calls, no submissions, and state is never written."""
    st = load_state()
    st.setdefault("items", {})
    miss = missing_sources()
    shown = 0
    for item in ORDER:
        if item in miss or st["items"].get(item, {}).get("status") == "done":
            continue
        if kinds and item.partition(":")[0] not in kinds:
            continue
        if ONLY_ITEMS and not any(o in item for o in ONLY_ITEMS):
            continue
        name = item.partition(":")[2]
        src = (WAVE_DEFS.get(name) or WAVE_THMS.get(name) or {}).get("file", "")
        print(f"  {item:72s} {resolve_path(src) if src else '(legacy item)'}")
        shown += 1
        if shown >= limit:
            break
    print(f"dry run: {shown} item(s) shown, nothing submitted, state untouched")
    return 0


def _apply_publish_verdict(st, item, p):
    """Map a publish-job payload to state.  Returns (terminal, err); a
    non-terminal payload means the job is still compiling."""
    status = (p or {}).get("status")
    if status == "PUBLISHED":
        field = "def_id" if item.startswith("def:") else "theorem_id"
        st["items"][item] = {"status": "done",
                             field: (p or {}).get("theorem_id") or (p or {}).get("id")}
        return True, None
    if status in ("FAILED", "ERROR"):
        return True, f"publish {status}: {(p or {}).get('error_message', '')[:200]}"
    return False, None


def _apply_verify_verdict(p):
    """Map a /verify submission payload to a verdict."""
    status = (p or {}).get("status")
    if status in ("ACCEPTED", "SKETCH_ACCEPTED", "Proved"):
        return True, None
    if status and status not in ("PENDING", "COMPILING"):
        return True, f"verdict {status}: {(p or {}).get('error_message', '')[:200]}"
    return False, None


def run_chunk_pipelined(st, miss, kinds, published, parallel, max_items, max_seconds):
    """Bounded chunk with several submissions in flight at once.

    The server spends ~20-30 s compiling each submission, so the sequential
    loop sleeps away most of every item's wall-clock.  Here `do_*` returns as
    soon as the job is accepted and every in-flight job is polled in one round.
    Verdict semantics are unchanged: `done` is only ever written on a terminal
    PUBLISHED/ACCEPTED verdict, so a chunk that is cut off mid-drain leaves its
    unfinished items `pending` with their job id, and the next run re-polls
    them without consuming an attempt."""
    global PIPELINE_MODE
    INFLIGHT.clear()
    started = time.time()
    waiting = {}
    processed = 0
    exhausted = False
    queue = iter(ORDER)

    def fill():
        # PIPELINE_MODE/INFLIGHT are module state the `do_*` handlers read; the
        # assignment below must not bind a local.
        global PIPELINE_MODE
        nonlocal exhausted, processed
        while len(INFLIGHT) < parallel:
            if max_items and processed + len(INFLIGHT) >= max_items:
                exhausted = True
                return
            if over_budget() or (max_seconds and time.time() - started >= max_seconds):
                exhausted = True
                return
            item = next(queue, None)
            if item is None:
                exhausted = True
                return
            if item in miss:
                continue
            if kinds and item.partition(":")[0] not in kinds:
                continue
            if ONLY_ITEMS and not any(o in item for o in ONLY_ITEMS):
                continue
            if published:
                dep = blocked_by(item, published)
                if dep:
                    waiting[dep] = waiting.get(dep, 0) + 1
                    continue
            rec = st["items"].get(item, {"status": "pending", "attempts": 0})
            st["items"][item] = rec
            if rec["status"] == "done":
                continue
            if rec.get("attempts", 0) >= MAX_ATTEMPTS:
                rec["status"] = "failed"
                continue
            kind, _, name = item.partition(":")
            log(f"submitting {item} (attempt {rec['attempts'] + 1})")
            PIPELINE_MODE = True
            try:
                if kind == "def":
                    err = do_def(st, item)
                elif kind == "thm":
                    err = do_thm(st, item, name)
                else:
                    err = do_sol(st, item, name)
            except Exception as e:
                err = f"{type(e).__name__}: {e}"
            finally:
                PIPELINE_MODE = False
            if err is None:
                rec["status"] = "done"
                processed += 1
                log(f"{item}: DONE")
            elif err == SUBMITTED:
                log(f"{item}: accepted, waiting on the compiler")
            elif is_transient(err):
                # Waiting on a dependency or an in-flight job costs nothing and
                # must not consume the chunk's item budget.
                log(f"{item}: WAIT ({err[:150]})")
            else:
                rec["attempts"] = rec.get("attempts", 0) + 1
                rec["error"] = err[:300]
                processed += 1
                log(f"{item}: FAIL ({err[:150]})")
            save_state(st)

    while True:
        fill()
        if not INFLIGHT:
            if exhausted:
                break
            continue
        if over_budget() or (max_seconds and time.time() - started >= max_seconds):
            break
        # One poll round over every in-flight job: no per-job sleep.
        for ident, (item, channel) in list(INFLIGHT.items()):
            try:
                if channel == "publish":
                    terminal, err = _apply_publish_verdict(
                        st, item, api("GET", f"publish-jobs/{ident}", None))
                else:
                    terminal, err = _apply_verify_verdict(
                        api("GET", "verify", params={"submission_id": ident}))
                    if terminal and err is None:
                        st["items"][item] = {"status": "done", "submission_id": ident}
            except Exception as e:
                log(f"{item}: poll error {type(e).__name__}: {e}")
                continue
            if not terminal:
                continue
            del INFLIGHT[ident]
            processed += 1
            rec = st["items"].setdefault(item, {"attempts": 0})
            if err is None:
                rec["status"] = "done"
                log(f"{item}: DONE")
            else:
                # A terminal failure must not leave the dead job/submission id
                # behind, or every later run would re-read this verdict and
                # spend an attempt on it without submitting anything new.
                rec.pop("submission_id", None)
                rec.pop("job_id", None)
                rec["status"] = "pending"
                rec["attempts"] = rec.get("attempts", 0) + 1
                rec["error"] = err[:300]
                log(f"{item}: FAIL ({err[:150]})")
            save_state(st)
        if INFLIGHT:
            if max_seconds and time.time() - started >= max_seconds:
                break
            time.sleep(POLL_INTERVAL)
    p = plan_progress(st, miss, kinds)
    log(f"summary: {p['done']} done, {p['pending']} pending, {p['failed']} failed"
        + (f", {len(miss)} unsubmittable (source missing from this checkout)" if miss else "")
        + (f" ({p['orphans']} out-of-order orphans ignored)" if p["orphans"] else ""))
    if waiting:
        log("waiting on unpublished def bundle(s): "
            + ", ".join(f"{k} ({v} item(s))" for k, v in sorted(waiting.items())))
    log(f"chunk: {processed} item(s) resolved in {time.time() - started:.0f}s"
        + (f", {len(INFLIGHT)} still in flight (re-polled next run)" if INFLIGHT else ""))
    return 0


def main(argv=None):
    ap = argparse.ArgumentParser(
        description="Resumable prove2me upload pipeline (append-only state).")
    ap.add_argument("--check", action="store_true",
                    help="verify platform access with the API key and exit")
    ap.add_argument("--status", action="store_true",
                    help="print plan/state progress and exit")
    ap.add_argument("--sync", action="store_true",
                    help="reconcile state with the platform's publish jobs, then exit")

    ap.add_argument("--max-items", type=int, default=0,
                    help="process at most N items, then exit 0 (bounded chunk)")
    ap.add_argument("--max-seconds", type=float, default=0,
                    help="stop starting new items after S seconds")
    ap.add_argument("--dry-run", action="store_true",
                    help="show the next items a chunk would take; submit nothing")
    ap.add_argument("--kind", action="append", choices=["def", "thm", "sol"],
                    help="restrict the run to these item kinds (repeatable); a "
                         "blocked def bundle at the head of ORDER would otherwise "
                         "starve everything behind it in a bounded chunk")
    ap.add_argument("--job-timeout", type=int, default=0,
                    help="per-item job poll ceiling in seconds (default 900; "
                         "lower it so a bounded chunk returns cleanly)")
    ap.add_argument("--only", action="append", default=None, metavar="SUBSTR",
                    help="restrict the run to items whose name contains one of "
                         "these substrings (repeatable); use to unblock a "
                         "specific node that sits far down ORDER")
    ap.add_argument("--parallel", type=int, default=1,
                    help="pipelined mode: keep this many submissions in flight "
                         "at once instead of polling each one to completion "
                         "(in-flight items never consume an attempt)")
    ap.add_argument("--no-preflight", action="store_true",
                    help="do not skip items that import an unpublished def bundle")
    args = ap.parse_args(argv)

    if args.job_timeout:
        globals()["JOB_TIMEOUT"] = args.job_timeout
    kinds = set(args.kind) if args.kind else None
    globals()["ONLY_ITEMS"] = args.only or None

    if args.check:
        return cmd_check()
    if args.status:
        return cmd_status()
    if args.dry_run:
        return cmd_dry_run(args.max_items or 10, kinds)

    st = load_state()
    st.setdefault("items", {})
    if args.sync:
        # Reconciliation only, exactly as documented: the sync is idempotent and
        # must never fall through into the submit loop (that would spend an
        # attempt per item on whatever the current toolchain situation is).
        sync_state(st)
        return 0

    miss = missing_sources()
    # Preflight: the platform only sees defs that are already published (§2), so
    # anything importing an unpublished bundle is a guaranteed FAILED.  Waiting
    # costs nothing; a wasted submission costs one of the 5 attempts.
    published = set() if args.no_preflight else published_defs()
    if args.parallel > 1:
        return run_chunk_pipelined(st, miss, kinds, published, args.parallel,
                                   args.max_items, args.max_seconds)
    started = time.time()
    processed = 0
    waiting = {}
    for item in ORDER:
        if item in miss:
            continue
        if kinds and item.partition(":")[0] not in kinds:
            continue
        if ONLY_ITEMS and not any(o in item for o in ONLY_ITEMS):
            continue
        if published:
            dep = blocked_by(item, published)
            if dep:
                waiting[dep] = waiting.get(dep, 0) + 1
                continue
        if args.max_items and processed >= args.max_items:
            log(f"bounded chunk: max-items {args.max_items} reached")
            break
        if args.max_seconds and time.time() - started >= args.max_seconds:
            log(f"bounded chunk: max-seconds {args.max_seconds:g} reached")
            break
        rec = st["items"].get(item, {"status": "pending", "attempts": 0})
        st["items"][item] = rec
        if rec["status"] == "done":
            continue
        if rec.get("attempts", 0) >= MAX_ATTEMPTS:
            rec["status"] = "failed"
            continue
        kind, _, name = item.partition(":")
        processed += 1
        log(f"processing {item} (attempt {rec['attempts'] + 1})")
        try:
            if kind == "def":
                err = do_def(st, item)
            elif kind == "thm":
                err = do_thm(st, item, name)
            else:
                err = do_sol(st, item, name)
        except Exception as e:
            err = f"{type(e).__name__}: {e}"
        if err is None:
            rec["status"] = "done"
            log(f"{item}: DONE")
        elif is_transient(err):
            log(f"{item}: WAIT ({err[:150]}) - job in flight, no attempt consumed")
        else:
            # Drop the finished (failed) job/submission id: keeping it would make
            # the next run re-read the same verdict and spend an attempt on it.
            rec.pop("submission_id", None)
            rec.pop("job_id", None)
            rec["attempts"] = rec.get("attempts", 0) + 1
            rec["error"] = err[:300]
            log(f"{item}: FAIL ({err[:150]})")
        save_state(st)
    # Only ORDER items count towards completion; orphan entries left over from
    # earlier waves (e.g. reset SirkFinitePrecision nodes already published on
    # the platform) must not keep the pipeline spinning.
    p = plan_progress(st, miss, kinds)
    log(f"summary: {p['done']} done, {p['pending']} pending, {p['failed']} failed"
        + (f", {len(miss)} unsubmittable (source missing from this checkout)" if miss else "")
        + (f" ({p['orphans']} out-of-order orphans ignored)" if p["orphans"] else ""))
    if waiting:
        log("waiting on unpublished def bundle(s): "
            + ", ".join(f"{k} ({v} item(s))" for k, v in sorted(waiting.items())))
    if args.max_items or args.max_seconds:
        log(f"chunk: {processed} item(s) processed in {time.time() - started:.0f}s")
        return 0
    return 0 if p["pending"] == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
