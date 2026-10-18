#!/usr/bin/env python3
"""Phase-5 type diff for the §2.64 heal: for every healed node, elaborate
`@<dotted>` (corrected target, sorry-stub) and `@solution` in ONE file against
the published mirror and require the printed types to be equal up to universe
display names (upload_full_project.md Phase 5: the only acceptable difference
is `u_1` vs `u_2`).

For each node:
  1. mirror_closure builds the thm module + import closure,
  2. combined file = sol text + `import Theorems.Thm_<slug>` + two `#check`s,
  3. `lean` runs it; types are extracted after `@name :` and compared.

Usage:
  python3 debug/verify_include_heal.py            # all healed nodes
  python3 debug/verify_include_heal.py --only X   # substring filter
"""
import json
import os
import re
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
PROJ = os.environ.get(
    "TIMEPIECE_PROJ",
    "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/timepiece331")
MIRROR = "/tmp/published_mirror"


def lake_env(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def healed_slugs():
    wave = json.load(open(os.path.join(WS, "pipeline", "wave_upload.json")))
    slugs = [s for s in wave["thms"] if s.endswith("_inc")]
    # in-place fixes: detect via .bak_inc backups
    for d, kind in (("Theorems", "Thm_"), ("Solutions", "Sol_")):
        pass
    for fn in sorted(os.listdir(os.path.join(WS, "Theorems"))):
        if fn.endswith(".lean.bak_inc"):
            slug = fn[len("Thm_"):-len(".lean.bak_inc")]
            if slug not in slugs:
                slugs.append(slug)
    return slugs


def norm(t):
    t = re.sub(r"\bu_\d+\b", "u", t)
    t = re.sub(r"\binst_\d+\b", "inst", t)
    t = re.sub(r"\binst✝\d*\b", "inst", t)
    return re.sub(r"\s+", " ", t).strip()


def extract_types(txt, dotted):
    """Type printed after `@... :` for `dotted` and for `solution`.  Lean may
    print the short name when its namespace is `open` in the file, so match on
    the last segment with any qualification."""
    last = dotted.rsplit(".", 1)[-1]
    out = {}
    for key in (last, "solution"):
        # the type starts on the SAME line as `@name :` and continues on
        # 2-space-indented lines; a col-0 `@... :` ends it.
        pat = re.compile(
            r"^@(?:(?:[A-Za-z0-9_'.]+)\.)*%s :(?P<body>.*(?:\n  .*)*)"
            % re.escape(key), re.M)
        m = pat.search(txt)
        if m:
            out[key] = m.group("body").strip()
    return out


def main():
    only = None
    if "--only" in sys.argv:
        only = sys.argv[sys.argv.index("--only") + 1]
    slugs = healed_slugs()
    if only:
        slugs = [s for s in slugs if only in s]
    wave = json.load(open(os.path.join(WS, "pipeline", "wave_upload.json")))
    base = lake_env('printf %s "$LEAN_PATH"')
    lean = lake_env("command -v lean")
    env = dict(os.environ, LEAN_PATH=MIRROR + ":" + base)

    results = {}
    for slug in sorted(slugs):
        ent = wave["thms"].get(slug)
        dotted = (ent or {}).get("name") or slug.replace("_", ".", 0)
        stub = os.path.join(WS, "Theorems", "Thm_%s.lean" % slug)
        sol = os.path.join(WS, "Solutions", "Sol_%s.lean" % slug)
        if not ent or not os.path.exists(stub) or not os.path.exists(sol):
            results[slug] = "SKIP (missing %s%s%s)" % (
                "" if ent else "wave ", "" if os.path.exists(stub) else "stub ",
                "" if os.path.exists(sol) else "sol")
            continue
        # 1. closure: force-rebuild the root (the stub may have been re-healed)
        root_o = os.path.join(MIRROR, "Theorems", "Thm_%s.olean" % slug)
        if os.path.exists(root_o):
            os.remove(root_o)
        r = subprocess.run([sys.executable, os.path.join(HERE, "mirror_closure.py"),
                            "Theorems.Thm_" + slug,
                            "--from-file", stub, sol],
                           capture_output=True, text=True)
        if "FAILED" in r.stdout:
            results[slug] = "SKIP (mirror): " + next(
                l for l in r.stdout.splitlines() if l.startswith("FAILED"))[:140]
            continue
        # 2. combined
        sol_txt = open(sol, encoding="utf-8").read()
        imports = [l for l in sol_txt.splitlines() if l.startswith("import ")]
        body = "\n".join(l for l in sol_txt.splitlines()
                         if not l.startswith("import "))
        combined = "\n".join(imports + ["import Theorems.Thm_" + slug, body,
                                        "#check @%s" % dotted,
                                        "#check @solution"]) + "\n"
        work = os.path.join(PROJ, "_verify_inc.lean")
        open(work, "w", encoding="utf-8").write(combined)
        try:
            p = subprocess.run([lean, "_verify_inc.lean"], cwd=PROJ, env=env,
                               capture_output=True, text=True, timeout=420)
            out = p.stdout + p.stderr
        finally:
            if os.path.exists(work):
                os.remove(work)
        errs = [l for l in out.splitlines() if ": error:" in l]
        if errs:
            results[slug] = "COMPILE: " + errs[0][:160]
            continue
        tt = extract_types(out, dotted)
        st = extract_types(out, dotted)
        tgt, solty = tt.get(last if (last := dotted.rsplit('.', 1)[-1]) else ""), st.get("solution")
        if not tgt or not solty:
            results[slug] = "PARSE: #check output missing"
            dbg = os.path.join(WS, "state", "verify_dbg_%s.txt" % slug)
            open(dbg, "w").write(
                "--- combined ---\n%s\n--- out ---\n%s\n--- err ---\n%s"
                % (combined[:1500], out[:1500], p.stderr[:800]))
        elif norm(tgt) == norm(solty):
            results[slug] = "OK"
        else:
            results[slug] = "MISMATCH"
            results[slug + ".__target"] = tgt[:600]
            results[slug + ".__solution"] = solty[:600]
        print("%-90s %s" % (slug[:90], results[slug][:100]), flush=True)

    ok = sum(1 for v in results.values() if v == "OK")
    bad = [k for k, v in results.items() if v != "OK" and not k.endswith(
        ("__target", "__solution"))]
    print("=== verify_include_heal: %d OK, %d not-OK" % (ok, len(bad)))
    for k in bad:
        print("  %s -> %s" % (k, results[k][:180]))
        if results.get(k) == "MISMATCH":
            print("     target  :", results.get(k + ".__target", "")[:400])
            print("     solution:", results.get(k + ".__solution", "")[:400])
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main())
