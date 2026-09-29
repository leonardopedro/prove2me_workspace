"""Which unpublished def bundles are READY to publish, and which wait on a sibling?

The def layer is a dependency chain, not a list: a bundle that opens a namespace
no *published* module declares is rejected with `unknown namespace BookProof.X`
(SKILL.md §1e — the platform compiles one module at a time and does not carry a
transitive import's namespaces into scope), no matter how correct its own body is.
So the drain order is a fixed point: publish the ready layer, re-read the index,
and the next layer becomes ready.

Ground truth is the platform: `state/defs_index.json` (`namespace_owner`, built by
`debug/platform_def_index.py`).  Opens are resolved with the generator's alias rule
(BookProof.A.B <-> BookProof.ChapterA.B), and an unpublished namespace is attributed
to the LOCAL bundle that declares it, so a blocker names the exact predecessor to
publish first.  `NOSOURCE` means no local Definitions bundle declares it either —
that is the §1f residual class (needs the source chapter / the sanctioned
generator), not an ordering problem.

Usage:
  python3 debug/def_layer_order.py            # pending defs from the wave plan
  python3 debug/def_layer_order.py --all      # every Definitions bundle, published or not
"""
import argparse
import json
import os
import re
import sys

WS = (os.environ.get("PROVE2ME_WS")
      or os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.path.insert(0, f"{WS}/pipeline")

DECL = re.compile(r"^namespace\s+([\w.']+)")
SEC = re.compile(r"^(?:noncomputable\s+)?section\b")
END = re.compile(r"^end\b")
OPEN = re.compile(r"^open\s+([^\n]+)", re.M)
IMPORTS = re.compile(r"^import\s+Definitions\.Def_(\S+)", re.M)


def local_declarers():
    """namespace -> defining bundle leaf, with `section`/`namespace` pushed and
    popped on the same stack (a section-closed namespace is not a namespace end)."""
    out = {}
    for f in sorted(os.listdir(f"{WS}/Definitions")):
        if not (f.startswith("Def_") and f.endswith(".lean")):
            continue
        leaf = f[len("Def_"):-len(".lean")]
        st = []
        for ln in open(f"{WS}/Definitions/{f}", encoding="utf-8", errors="replace"):
            m = DECL.match(ln)
            if m:
                st.append(("ns", m.group(1)))
                out.setdefault(".".join(n for k, n in st if k == "ns"), leaf)
            elif SEC.match(ln):
                st.append(("sec", None))
            elif END.match(ln) and st:
                st.pop()
    return out


def opens_of(path):
    text = re.sub(r"^import .*\n", "", open(path, encoding="utf-8", errors="replace").read(),
                  flags=re.M)
    return {t.strip('(){},"') for line in OPEN.findall(text) for t in line.split()
            if t.strip('(){},"').startswith("BookProof.")}


def variants(ns):
    parts = ns.split(".")
    for i in range(1, len(parts)):
        if parts[i].startswith("Chapter") and len(parts[i]) > len("Chapter"):
            yield ".".join(parts[:i] + [parts[i][len("Chapter"):]] + parts[i + 1:])
        else:
            yield ".".join(parts[:i] + ["Chapter" + parts[i]] + parts[i + 1:])


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--all", action="store_true",
                    help="consider every Definitions bundle, not just pending plan items")
    args = ap.parse_args()

    idx = json.load(open(f"{WS}/state/defs_index.json"))
    pub = set(idx.get("namespace_owner") or {})
    declarer = local_declarers()
    print(f"platform: {len(pub)} published namespace(s); local declarers: {len(declarer)}")

    if args.all:
        leaves = sorted(f[len("Def_"):-len(".lean")] for f in os.listdir(f"{WS}/Definitions")
                        if f.startswith("Def_") and f.endswith(".lean"))
        pending = [c for c in leaves
                   if c not in {v for v in (idx.get("bundles") or {}).values() and [] or []}]
        # published bundle names, from both the index and the state file
        published = {k for k, v in (idx.get("bundles") or {}).items() if v.get("status") == "PUBLISHED"}
        state = json.load(open(f"{WS}/state/pipeline.json"))["items"]
        published |= {k[len("def:"):] for k, v in state.items()
                      if k.startswith("def:") and v.get("status") == "done"}
        pending = [c for c in leaves if c not in published]
    else:
        import upload_pipeline as up
        miss = up.missing_sources()
        state = json.load(open(f"{WS}/state/pipeline.json"))["items"]
        pending = [i[len("def:"):] for i in up.ORDER if i.startswith("def:") and i not in miss
                   and state.get(i, {}).get("status") not in ("done", "failed")]

    # Which bundles the platform actually has, for the import gate: importing an
    # UNPUBLISHED `Definitions.Def_X` fails the submit preflight just as hard as
    # opening an undeclared namespace fails the compiler, so a bundle that is
    # `open`-clean still cannot be submitted until its imports exist.
    published_bundles = {k for k, v in (idx.get("bundles") or {}).items()
                         if v.get("status") == "PUBLISHED"}
    st_all = json.load(open(f"{WS}/state/pipeline.json"))["items"]
    published_bundles |= {k[len("def:"):] for k, v in st_all.items()
                          if k.startswith("def:") and v.get("status") == "done"}

    def imports_of(path):
        txt = open(path, encoding="utf-8", errors="replace").read()
        return sorted(set(IMPORTS.findall(txt)))

    ready, blocked = [], {}
    for c in pending:
        p = f"{WS}/Definitions/Def_{c}.lean"
        if not os.path.exists(p):
            blocked[c] = ["NO FILE"]
            continue
        need = [f"open {ns} <- {declarer.get(ns, 'NOSOURCE')}" for ns in sorted(opens_of(p))
                if ns not in pub and not any(v in pub for v in variants(ns))]
        need += [f"import Def_{d} <- unpublished" for d in imports_of(p)
                 if d != c and d not in published_bundles]
        if need:
            blocked[c] = need
        else:
            ready.append(c)
    print(f"\nPENDING def bundles: {len(pending)}")
    print(f"READY (every open already published): {len(ready)}")
    for c in ready:
        print(f"    {c}")
    print(f"BLOCKED: {len(blocked)}")
    for c, need in sorted(blocked.items(), key=lambda kv: len(kv[1])):
        print(f"    {c:42s} {len(need):2d}: {', '.join(need[:3])}{' …' if len(need) > 3 else ''}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
