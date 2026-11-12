"""Give a DEF bundle the `Theorems.*` import for each helper only a theorem node provides.

Published def bundles are pruned: every lemma a chapter declares next to its
definitions (`pushOp_apply`, `sectorOp_apply`, `annPoly_apply`, ...) is dropped
from the published text and published instead as its own problem
(`Thm_BookProof_<Chapter>_<name>`).  A def bundle that *proves* something with
such a lemma therefore compiles locally (workspace def text still has it) and
fails on the platform with `Unknown identifier`.  This adds the import.

Names with no theorem node (rfl-lemmas like `restrictOp_apply`) are listed as
UNRESOLVED for a manual fix -- never silently guessed at.

Dry run by default; --write to edit.
"""
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DECL = re.compile(r"^(?:@\[[^\n]*\]\s*)?(?:private\s+|protected\s+|noncomputable\s+|partial\s+|nonrec\s+)*"
                  r"(?:theorem|lemma|def|abbrev|structure|class|inductive|instance|opaque)\s+"
                  r"([A-Za-z_][A-Za-z0-9_.'!?]*)", re.M)
IMPORT_DEF = re.compile(r"^import\s+Definitions\.(Def_\w+)", re.M)
IMPORT_THM = re.compile(r"^import\s+Theorems\.(Thm_\w+)", re.M)


def decls(path):
    try:
        txt = open(path, encoding="utf-8").read()
    except OSError:
        return set()
    return {m.group(1).split(".")[-1] for m in DECL.finditer(txt)}


def thm_index():
    """short declared name -> [Thm modules] (a short name can repeat)."""
    out = {}
    d = os.path.join(WS, "Theorems")
    for f in os.listdir(d):
        if not (f.startswith("Thm_") and f.endswith(".lean")):
            continue
        try:
            txt = open(os.path.join(d, f), encoding="utf-8", errors="ignore").read()
        except OSError:
            continue
        m = DECL.search(txt)
        if m:
            out.setdefault(m.group(1).split(".")[-1], []).append(f[:-5])
    return out


def chapter_of_thm(mod):
    """`Thm_BookProof_ChapterFoo_bar` -> `ChapterFoo` (best effort: try the
    target's own import list as the truth, this is only for reporting)."""
    return mod[len("Thm_BookProof_"):].split("_")[0] if mod.startswith("Thm_BookProof_") else mod


def main(argv):
    write = "--write" in argv
    chapters = [a for a in argv if not a.startswith("--")]
    idx = thm_index()
    for ch in chapters:
        src = os.path.join(WS, f"Definitions/Def_{ch}.lean")
        txt = open(src, encoding="utf-8").read()
        toks = set(re.findall(r"[A-Za-z_][A-Za-z0-9_']*", IMPORT_DEF.sub("", txt)))
        have = set(IMPORT_THM.findall(txt))
        add, unresolved = [], []
        seen = set()
        for mod in sorted(set(IMPORT_DEF.findall(txt))):
            pub = os.path.join(WS, f"state/published_bundles/{mod}.lean")
            ws = os.path.join(WS, f"Definitions/{mod}.lean")
            if not os.path.exists(pub):
                continue
            for name in sorted(decls(ws) - decls(pub)):
                if name not in toks or name in seen or len(name) < 4:
                    continue
                seen.add(name)
                cands = idx.get(name) or []
                t = cands[0] if len(cands) == 1 else None
                if t and t not in have:
                    add.append((name, t))
                    have.add(t)
                elif not t:
                    unresolved.append((mod, name))

        # Second class: a helper this bundle cites that the workspace does not
        # declare anywhere either -- it exists only as a theorem node (e.g.
        # `crePoly_hermiteMvLp`: the def chapter documents it, the proof lives in
        # `Thm_BookProof_HermiteProductBasis_crePoly_hermiteMvLp`).  Only chapter-
        # local names qualify, so Mathlib's `id` / `map_zero` are never imported.
        own = decls(src)
        # A name a PUBLISHED dep bundle already carries must not also come in as a
        # theorem node: the node would re-declare it (`gaussInt_add` sits in the
        # published Def_ChapterHermiteProductCore *and* in a Thm stub).
        for m in sorted(set(IMPORT_DEF.findall(txt))):
            own |= decls(os.path.join(WS, f"state/published_bundles/{m}.lean"))
        # Thm modules are named both `Thm_BookProof_ChapterFoo_x` and
        # `Thm_BookProof_Foo_x`, so a chapter answers to both spellings.
        chapters = set()
        for m in IMPORT_DEF.findall(txt):
            c = m[len("Def_"):]
            chapters.add(c)
            chapters.add(c[len("Chapter"):] if c.startswith("Chapter") else c)
        for name, cands in sorted(idx.items()):
            if name in seen or name in own or len(cands) != 1 or name not in toks:
                continue
            mod = cands[0]
            if len(name) < 4 or mod in have:
                continue
            if any(mod.startswith(f"Thm_BookProof_{c}_") for c in chapters):
                add.append((name, mod))
                have.add(mod)
        print(f"== {ch}: +{len(add)} theorem import(s), {len(unresolved)} unresolved")
        for name, t in add:
            print(f"   + {t}   ({name})")
        for mod, name in unresolved:
            print(f"   ? {name}  (ws-only in {mod}, no theorem node)")
        if write and add:
            lines = txt.split("\n")
            at = max(i for i, l in enumerate(lines) if l.startswith("import "))
            lines[at + 1:at + 1] = [f"import Theorems.{t}" for _, t in add]
            open(src, "w", encoding="utf-8").write("\n".join(lines))
            print(f"   wrote {src}")


if __name__ == "__main__":
    main(sys.argv[1:])
