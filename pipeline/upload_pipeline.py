#!/usr/bin/env python3
"""Resilient uploader for the timepiece transplant pipeline (runs as upload-timepiece.service).

Items are processed in order; progress is saved after EVERY item so a crash or
reboot loses at most the in-flight item. The script exits non-zero while work
remains (Restart=on-failure keeps it going) and exits 0 when everything is done.
"""
import json
import os
import re
import subprocess
import sys
import time
import urllib.parse

WS = "/home/leo/prove2me_workspace"
PIPE = f"{WS}/pipeline"
STATE_FILE = f"{WS}/state/pipeline.json"
LOG = f"{WS}/state/pipeline.log"
API = "https://prove2.me/api/v1"
MAX_ATTEMPTS = 5
JOB_TIMEOUT = 900

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
def topological_def_order(defs):
    """Compute topological order of def bundles respecting cross-bundle dependencies."""
    dep_graph = {}
    for name, meta in defs.items():
        filepath = meta['file']
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
    r = subprocess.run(cmd, capture_output=True, text=True, timeout=90)
    try:
        return json.loads(r.stdout)
    except ValueError:
        return None


def norm_stmt(text):
    return re.sub(r"\s+", " ", text or "").strip()


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


def local_compile(path):
    try:
        r = subprocess.run(["/home/leo/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lake", "env", "lean", path],
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
        "theorem_title": meta["title"],
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
    save_state(st)
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
    rec = st["items"].get(item, {})
    if rec.get("job_id"):
        p = poll_job(rec["job_id"])
        if p.get("status") == "PUBLISHED":
            st["items"][item] = {"status": "done", "def_id": p.get("theorem_id") or p.get("id")}
            return None
        if p.get("status") in ("PENDING", "COMPILING", None):
            return "def job still in flight"
    path = meta["file"]
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
        "definition_title": meta["title"],
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
    save_state(st)
    p = poll_job(jobs[0]["job_id"])
    if p.get("status") == "PUBLISHED":
        st["items"][item] = {"status": "done", "def_id": p.get("theorem_id") or p.get("id")}
        return None
    return f"publish {p.get('status')}: {p.get('error_message', '')[:200]}"


def do_wave_thm(st, item, slug):
    meta = WAVE_THMS[slug]
    rec = st["items"].get(item, {})
    if rec.get("job_id"):
        p = poll_job(rec["job_id"])
        if p.get("status") == "PUBLISHED":
            st["items"][item] = {"status": "done", "theorem_id": p.get("theorem_id")}
            return None
        if p.get("status") in ("PENDING", "COMPILING", None):
            return "theorem job still in flight"
    path = meta["file"]
    ok, err = local_compile(path)
    if not ok:
        return f"local compile failed: {err[:200]}"
    txt = open(path, encoding="utf-8").read()
    # Split at the top-level `theorem <dotted name>` declaration: everything
    # before it (imports/opens/variables/`omit … in`) is the preamble, the
    # declaration itself is the formal_statement.  Handles files where the
    # theorem line directly follows `omit … in` (no blank line before it).
    name = meta["name"]
    m = re.search(r"(?m)^theorem\s+" + re.escape(name) + r"\b", txt)
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
    r = api("POST", "submit-problem", {
        "theorem_name": name,
        "theorem_title": meta["title"],
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
    save_state(st)
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


def do_wave_sol(st, item, slug):
    meta = WAVE_THMS[slug]
    thm = st["items"].get(f"thm:{slug}", {})
    tid = thm.get("theorem_id")
    if thm.get("status") != "done" or not tid:
        return "theorem not published yet"
    if thm.get("reused_status") == "Proved":
        st["items"][item] = {"status": "done", "skipped": "theorem already Proved on platform"}
        return None
    path = f"{WS}/Solutions/Sol_{slug}.lean"
    ok, err = local_compile(path)
    if not ok:
        return f"local compile failed: {err[:200]}"
    explanation = sol_explanation(slug, meta)
    r = subprocess.run(["curl", "-s", "-X", "POST", f"{API}/verify",
                        "-H", f"Authorization: Bearer {token()}",
                        "-F", f"theorem_id={tid}",
                        "-F", f"file=@{path}",
                        "-F", f"explanation={explanation}"],
                       capture_output=True, text=True, timeout=90)
    try:
        resp = json.loads(r.stdout)
    except ValueError:
        return f"verify rejected (non-JSON): {r.stdout[:200]}"
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


def do_def(st, item):
    name = item.partition(":")[2]
    if name in WAVE_DEFS:
        return do_wave_def(st, item, name)
    return _do_legacy_def(st, item)


def do_thm(st, item, name):
    if name in WAVE_THMS:
        return do_wave_thm(st, item, name)
    return _do_legacy_thm(st, item, name)


def do_sol(st, item, name):
    if name in WAVE_THMS:
        return do_wave_sol(st, item, name)
    return _do_legacy_sol(st, item, name)


def main():
    st = load_state()
    st.setdefault("items", {})
    pending = 0
    for item in ORDER:
        rec = st["items"].get(item, {"status": "pending", "attempts": 0})
        st["items"][item] = rec
        if rec["status"] == "done":
            continue
        if rec.get("attempts", 0) >= MAX_ATTEMPTS:
            rec["status"] = "failed"
            continue
        kind, _, name = item.partition(":")
        pending += 1
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
        else:
            rec["attempts"] = rec.get("attempts", 0) + 1
            rec["error"] = err[:300]
            log(f"{item}: FAIL ({err[:150]})")
        save_state(st)
    # Only ORDER items count towards completion; orphan entries left over from
    # earlier waves (e.g. reset SirkFinitePrecision nodes already published on
    # the platform) must not keep the pipeline spinning.
    in_order = set(ORDER)
    n_done = sum(1 for k, i in st["items"].items() if k in in_order and i["status"] == "done")
    n_pend = sum(1 for k, i in st["items"].items() if k in in_order and i["status"] == "pending")
    n_fail = sum(1 for k, i in st["items"].items() if k in in_order and i["status"] == "failed")
    n_orphan = len(st["items"]) - sum(1 for k in st["items"] if k in in_order)
    log(f"summary: {n_done} done, {n_pend} pending, {n_fail} failed"
        + (f" ({n_orphan} out-of-order orphans ignored)" if n_orphan else ""))
    sys.exit(0 if n_pend == 0 else 1)


if __name__ == "__main__":
    main()
