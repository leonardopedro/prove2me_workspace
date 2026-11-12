#!/usr/bin/env python3
"""Drop `variable` binder groups whose name is re-declared LATER in the file.

THE DEFECT this repairs (PIPELINE_PLAN §8.1, FockStatistics class): a stub can
carry the section block twice --

    variable {Hs : IPSpace} [CompleteSpace Hs.carrier] {D : Submodule ℂ Hs.carrier}
      (A : D →ₗ[ℂ] Hs.carrier) (hdense : ...) (hsym : ...) (hesa : ...)   -- section
    variable (Hs : IPSpace) (D : Submodule ℂ Hs.carrier) (A : D →ₗ[ℂ] Hs.carrier)  -- chapter scan

Lean accepts the second command as NEW variables `Hs_1 D_1 A_1`.  `include
hdense hsym hesa in` then binders the hypotheses about the FIRST (Hs, D, A)
while the conclusion mentions the second set, so the elaborated target is
`... → P (Hs_1) (D_1) (A_1)` with hypotheses about an unrelated `(D, A)`: no
proof can exist and every sol attempt burns a turn.

Rule: a name belongs to its FIRST `variable` declaration; later re-declarations
are dropped.  Nothing can then reference a name that is not yet declared, so
the result always elaborates, and every reference -- hypotheses, `include`,
statement -- resolves to the surviving binder, which is what makes the target
provable.  (Verified on a probe: the duplicated form elaborates to
`∀ (D P Q) (hdense : D ⊆ P) → ∀ (D_1 P_1), D_1 ⊆ P_1`.)  The section block is
the first one, so this also reproduces the shape the published `_inc` twins
carry.  Identical-block dedupe alone does not catch it: the two blocks are not
textually equal.

Usage:
  python3 debug/dedup_variable_binders.py FILE...            # rewrite in place
  python3 debug/dedup_variable_binders.py --dry-run FILE...
  python3 debug/dedup_variable_binders.py --slug SLUG        # Theorems+Solutions

Exit 0 when nothing had to change, 10 when something did (or would, dry-run).
"""
import argparse
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

STOP = ("theorem", "lemma", "def", "abbrev", "instance", "structure", "end",
        "namespace", "open", "import", "noncomputable", "set_option", "omit",
        "include", "attribute", "section", "variable", "universe", "example",
        "--", "/-")


def split_groups(block):
    """Split a variable command's payload into binder groups.

    A group is `{...}`, `(...)`, `[...]`, or a bare `x y : T` run.  Nesting is
    tracked so `(hdense : Dense (D : Set Hs.carrier))` stays one group.
    """
    s = " ".join(line.strip() for line in block)
    s = re.sub(r"^variable\s+", "", s).strip()
    out, i, n = [], 0, len(s)
    while i < n:
        ch = s[i]
        if ch.isspace():
            i += 1
            continue
        if ch in "{([":
            depth, j = 0, i
            while j < n:
                if s[j] in "{([":
                    depth += 1
                elif s[j] in "})]":
                    depth -= 1
                    if depth == 0:
                        break
                j += 1
            out.append(s[i:j + 1])
            i = j + 1
            continue
        j = i
        while j < n and s[j] not in "{([":
            j += 1
        out.append(s[i:j].strip())
        i = j
    return [g for g in out if g]


def group_names(g):
    """The names a binder group introduces (empty for anonymous instances)."""
    if g[:1] not in "{([":
        return g.split(":", 1)[0].split()
    inner = g[1:-1]
    depth = 0
    for k, ch in enumerate(inner):
        if ch in "{([":
            depth += 1
        elif ch in "})]":
            depth -= 1
        elif ch == ":" and depth == 0:
            return inner[:k].split()
    return []


def rewrite(text, verbose=False):
    lines = text.split("\n")
    # Pass 1: collect every variable command in the preamble.
    cmds = []           # (line_index, [groups])
    i = 0
    while i < len(lines):
        if not re.match(r"^variable(\s|$)", lines[i]):
            i += 1
            continue
        block = [lines[i]]
        j = i + 1
        while (j < len(lines) and lines[j][:1].isspace() and lines[j].strip()
               and not lines[j].strip().startswith(STOP)):
            block.append(lines[j])
            j += 1
        cmds.append((i, j, split_groups(block)))
        i = j
    # First declaration wins, for names and for anonymous instances.
    drop = [set() for _ in cmds]
    seen_name = set()
    seen_anon = set()
    for ci, (_s, _e, groups) in enumerate(cmds):
        for gi, g in enumerate(groups):
            names = group_names(g)
            if names:
                if any(nm in seen_name for nm in names):
                    drop[ci].add(gi)
                else:
                    seen_name.update(names)
            else:
                sig = re.sub(r"\s+", " ", g)
                if sig in seen_anon:
                    drop[ci].add(gi)
                else:
                    seen_anon.add(sig)
    changed = False
    if not any(drop):
        return text, False
    out = list(lines)
    for ci in range(len(cmds) - 1, -1, -1):
        if not drop[ci]:
            continue
        changed = True
        start, end, groups = cmds[ci]
        kept = [g for gi, g in enumerate(groups) if gi not in drop[ci]]
        if verbose:
            for gi in sorted(drop[ci]):
                print("  drop %s" % groups[gi][:70])
        newlines = []
        if kept:
            cur = "variable"
            for g in kept:
                if len(cur) + 1 + len(g) > 78 and cur != "variable":
                    newlines.append(cur)
                    cur = "  " + g
                else:
                    cur += " " + g
            newlines.append(cur)
        out[start:end] = newlines
    return "\n".join(out), changed


def targets(slug):
    return [os.path.join(WS, "Theorems", "Thm_%s.lean" % slug),
            os.path.join(WS, "Solutions", "Sol_%s.lean" % slug)]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("files", nargs="*")
    ap.add_argument("--slug", action="append", default=[])
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("-v", "--verbose", action="store_true")
    a = ap.parse_args()
    files = list(a.files)
    for s in a.slug:
        files.extend(p for p in targets(s) if os.path.exists(p))
    if not files:
        ap.error("no input")
    rc = 0
    for f in files:
        text = open(f, encoding="utf-8").read()
        new, changed = rewrite(text, a.verbose)
        if not changed:
            print("ok        %s" % os.path.basename(f))
            continue
        rc = 10
        print("%s %s" % ("would-fix" if a.dry_run else "fixed    ",
                         os.path.basename(f)))
        if not a.dry_run:
            open(f, "w", encoding="utf-8").write(new)
    return rc


if __name__ == "__main__":
    sys.exit(main())
