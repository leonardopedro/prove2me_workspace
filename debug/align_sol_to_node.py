#!/usr/bin/env python3
"""Rebuild a solution's declaration from its NODE statement, keeping the proof.

WHY
---
The platform rejects a correct proof with `Your proof does not match the target
type` when the solution's declaration does not elaborate to the same type as the
task's formal statement.  That is a *textual* property, not a mathematical one:
the FockStatistics node statements declare their binders twice --

    variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
      (A : D →ₗ[ℂ] Hs.carrier) (hdense : ...) (hsym : ...) (hesa : ...)
    variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)
    variable {D₀ : Submodule ℂ Hs.carrier}

-- and `variable` in Lean updates the *last* annotation for a name, so `D₀` ends
up implicit while `Hs`, `D`, `A` end up explicit.  A solution that writes the
"natural" version (`(D₀ : ...)`, or omits the second block) elaborates a
different Pi type and fails, however good the proof is.

So: copy the node's body verbatim (opens, `noncomputable section`, the whole
`variable` block, the `include ... in` prefix and the theorem statement), change
only the declared NAME to `solution`, and graft the solution's existing proof
term onto it.  The type is then identical by construction -- there is no textual
difference left in the declaration to differ.

The solution's own imports are kept (it imports the Theorem nodes it cites) and
the node's imports are unioned in; the solution's own `open`s are kept as well,
because its proof terms may be shorter for them.

Usage:
    python3 debug/align_sol_to_node.py --dry <slug> [...]
    python3 debug/align_sol_to_node.py --apply <slug> [...]
"""
import argparse
import os
import re
import shutil
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

DECL = re.compile(r"(?m)^(?:include\s[^\n]*\n)?theorem\s")


def split_imports(text):
    lines = text.split("\n")
    idx = [i for i, l in enumerate(lines) if l.startswith("import ")]
    head = lines[: idx[-1] + 1] if idx else []
    rest = lines[idx[-1] + 1:] if idx else lines
    return head, rest


def decl_start(lines):
    """Index of the `include ... in` / `theorem` line that starts the declaration."""
    for i, l in enumerate(lines):
        if l.startswith("theorem "):
            j = i - 1
            while j >= 0 and lines[j].strip() == "":
                j -= 1
            if j >= 0 and lines[j].startswith("include ") and lines[j].rstrip().endswith(" in"):
                return j
            return i
    return None


def sol_proof(text):
    m = DECL.search(text)
    if not m:
        raise SystemExit("no `theorem` declaration found")
    end = text.index(":=", m.end())
    proof = text[end + 2:].rstrip()
    if not proof:
        raise SystemExit("empty proof in the solution")
    return proof


def opens_of(body):
    return [l for l in body if l.startswith("open ")]


def rebuild(slug, node_text, sol_text):
    node_imports, node_body = split_imports(node_text)
    sol_imports, sol_body = split_imports(sol_text)
    proof = sol_proof(sol_text)

    # statement text, verbatim from the node, with only the NAME replaced
    start = decl_start(node_body)
    if start is None:
        raise SystemExit("no `theorem` declaration found in the node")
    head = node_body[:start]
    decl = "\n".join(node_body[start:])
    decl = re.sub(r"(?m)^(theorem\s+)\S+", r"\1solution", decl, count=1)
    cut = decl.rindex(":= by sorry")
    decl = decl[:cut].rstrip() + " := " + proof + "\n"

    sol_lines = sol_text.split("\n")
    first_import = next((i for i, l in enumerate(sol_lines) if l.startswith("import ")), 0)
    pre = sol_lines[:first_import]
    imports = [l for l in sol_imports if l.startswith("import ")]
    for imp in node_imports:
        if imp.startswith("import ") and imp not in imports:
            imports.append(imp)

    # the solution's opens that the node's body does not already carry; they go
    # after the node's own, before `noncomputable section` when there is one.
    have = set(opens_of(node_body))
    extra = [o for o in opens_of(sol_body) if o not in have]

    if extra:
        last_open = max((i for i, l in enumerate(head) if l.startswith("open ")),
                        default=None)
        if last_open is not None:
            head[last_open + 1:last_open + 1] = extra
        else:
            head = extra + [""] + head

    # keep the solution's heartbeat budget: the copied statements are large
    if "set_option maxHeartbeats" in sol_text:
        decl = "set_option maxHeartbeats 1000000 in\n" + decl

    return "\n".join(pre + imports + head + decl.split("\n"))


def main(argv):
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true")
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("slugs", nargs="+")
    a = ap.parse_args(argv)
    changed = 0
    for slug in a.slugs:
        np_ = f"{WS}/Theorems/Thm_{slug}.lean"
        sp = f"{WS}/Solutions/Sol_{slug}.lean"
        if not (os.path.exists(np_) and os.path.exists(sp)):
            print(f"  MISSING {slug}")
            continue
        node = open(np_, encoding="utf-8").read()
        sol = open(sp, encoding="utf-8").read()
        new = rebuild(slug, node, sol)
        if new == sol:
            print(f"  same     {slug}")
            continue
        changed += 1
        if not a.apply:
            import difflib
            diff = list(difflib.unified_diff(sol.split("\n"), new.split("\n"),
                                             "now", "aligned", lineterm="", n=2))
            print(f"  CHANGED  {slug}\n" + "\n".join(diff[:60]))
            continue
        bak = sp + ".bak_align"
        if not os.path.exists(bak):
            shutil.copy2(sp, bak)
        open(sp, "w", encoding="utf-8").write(new)
        print(f"  WROTE    {slug}")
    print(f"{changed} file(s) differ" + ("" if a.apply else "  (dry run; pass --apply)"))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
