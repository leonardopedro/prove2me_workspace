#!/usr/bin/env python3
"""Import the platform node that declares an identifier no def bundle declares.

`fix_sol_def_imports.py` / `fix_stub_def_imports.py` can only repair an
`Unknown identifier X` when some `Definitions.Def_*` bundle declares X. The
remaining class is an X that lives only in the source chapter — but which the
generator DID emit a theorem node for, as `Theorems/Thm_*_X.lean`. Importing
that node is the encouraged reduction route (importing another platform theorem
is explicitly allowed; if the child is still `Open` the server answers
`SKETCH_ACCEPTED`, a terminal success), so this pass wires up the import.

Identifiers with no def declaration *and* no theorem node are reported
`NO NODE` — those need the declaration itself published (`debug/add_wave_def.py`).

Usage:
  python3 debug/fix_node_imports.py --dry-run [--kind sol|thm|both]
  python3 debug/fix_node_imports.py
"""
import argparse
import json
import os
import re
import sys

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
DEFS = os.path.join(WS, "Definitions")
THMS = os.path.join(WS, "Theorems")
SOLS = os.path.join(WS, "Solutions")
STATE = os.path.join(WS, "state", "pipeline.json")

UNK_RE = re.compile(r"Unknown identifier `([^`]+)`")
# The declared name may be fully namespace-qualified (`theorem BookProof.X.foo`), so the
# pattern has to span dots; the identifier key is its final segment.
DECL_RE = re.compile(
    r'^\s*(?:@\[[^\]]*\]\s*)?(?:private\s+|protected\s+|noncomputable\s+|partial\s+|unsafe\s+)*'
    r'(?:def|theorem|lemma|abbrev|structure|class|instance|inductive)\s+([A-Za-z_][\w.\'.!?]*)')
NS_RE = re.compile(r'^namespace\s+([A-Za-z_][\w.]*)\s*$')


def _leaf(name):
    return name.rsplit(".", 1)[-1]


def def_declared():
    """Identifiers declared by any Definitions bundle."""
    out = set()
    for fn in sorted(os.listdir(DEFS)):
        if fn.startswith("Def_") and fn.endswith(".lean"):
            for line in open(os.path.join(DEFS, fn)):
                d = DECL_RE.match(line)
                if d:
                    out.add(_leaf(d.group(1)))
    return out


def node_stubs():
    """{identifier: module} for every `Theorems/Thm_*.lean` node.

    The declared name inside the stub is authoritative (it is the qualified target);
    found nothing when a stub has an empty body, so the module name's trailing
    underscore segment is used as a fallback.
    """
    out = {}
    for fn in sorted(os.listdir(THMS)):
        if not (fn.startswith("Thm_") and fn.endswith(".lean")):
            continue
        mod = fn[:-len(".lean")]
        out.setdefault(fn[len("Thm_"):-len(".lean")], mod)
        for line in open(os.path.join(THMS, fn)):
            d = DECL_RE.match(line)
            if d:
                out[_leaf(d.group(1))] = mod
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--only", action="append", default=[])
    ap.add_argument("--kind", choices=["sol", "thm", "both"], default="both")
    a = ap.parse_args()

    declared = def_declared()
    nodes = node_stubs()
    kinds = ("sol", "thm") if a.kind == "both" else (a.kind,)
    st = json.load(open(STATE))["items"]

    patched = no_node = 0
    for key, rec in sorted(st.items()):
        kind = key.split(":", 1)[0]
        if kind not in kinds or rec.get("status") == "done":
            continue
        if a.only and not any(s in key for s in a.only):
            continue
        names = [n for n in UNK_RE.findall(rec.get("error") or "") if "." not in n]
        if not names:
            continue
        name = key.split(":", 1)[1]
        path = os.path.join(SOLS if kind == "sol" else THMS,
                            ("Sol_" if kind == "sol" else "Thm_") + name + ".lean")
        if not os.path.exists(path):
            continue
        txt = open(path).read()
        add, unresolved = set(), []
        for n in names:
            if n in declared:
                continue                      # the def-bundle passes own this one
            mod = nodes.get(n)
            if mod is None or mod == ("Thm_" + name):
                unresolved.append(n)          # no node, or the item's own self-import
                continue
            if f"import Theorems.{mod}" not in txt:
                add.add(mod)
        if unresolved:
            print(f"{key}: NO NODE {sorted(unresolved)}")
            no_node += 1
        if not add:
            continue
        print(f"{key}: +import {sorted(add)}")
        patched += 1
        if a.dry_run:
            continue
        lines = txt.split("\n")
        last = max(i for i, l in enumerate(lines) if l.startswith("import "))
        for mod in sorted(add):
            lines.insert(last + 1, f"import Theorems.{mod}")
        open(path, "w").write("\n".join(lines))

    print(f"\n{'would patch' if a.dry_run else 'patched'} {patched} file(s), "
          f"{no_node} with no node to import")
    return 0


if __name__ == "__main__":
    sys.exit(main())
