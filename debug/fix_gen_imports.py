#!/usr/bin/env python3
"""Add the minimal `import` + `open` pair a generated file needs for names it
references but cannot resolve.

`build_thm` gives a stub only `import Mathlib` + `import Definitions.Def_<leaf>`
and `build_sol` likewise (plus intra-chapter `Theorems` deps), with opens from
`opens_for` rather than from the source chapter.  So any name the statement or
proof cites through an *intermediate* chapter — one the source imports but which
has no `Def_` bundle of its own — is an `Unknown identifier` on the platform, and
the compiler stops at the first one.  That is what rejected
`BookProof.GaussCoreQuadBounds.quadForm_harm_nonneg`: `harmCore` lives in
`BookProof.QgHermiteOscillator`, reached via `import BookProof.ChapterQgOuterFockEsa`,
a chapter with no bundle, so the chain and its namespace were both dropped.

Rather than importing the whole transitive project closure (73 bundles for that
one stub — ruinous compile cost), this resolves **only the names the file
actually uses**, and only accepts a provider whose namespace the *source chapter
opens* (otherwise the name would not be in scope unqualified there either).
Adding an import/open pair cannot introduce an ambiguity the source chapter did
not already have: the generated file sees a subset of the declarations the source
did, with the same opens, so anything ambiguous here was ambiguous there — and
there it compiled.

Usage:
  python3 debug/fix_gen_imports.py Theorems/Thm_BookProof_GaussCoreQuadBounds_quadForm_harm_nonneg.lean
  python3 debug/fix_gen_imports.py --pending-thms [--dry-run]
  python3 debug/fix_gen_imports.py --all [--dry-run]
"""
import glob
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

DECL = re.compile(
    r"(?m)^\s*(?:noncomputable\s+|private\s+|protected\s+|@\[[^\]]*\]\s*)*"
    r"(?:def|abbrev|theorem|lemma|structure|inductive|class|instance)\s+"
    r"([A-Za-z_][A-Za-z0-9_'.]*)")
IMPORT = re.compile(r"(?m)^import\s+(\S+)")
LAST_IMPORT = re.compile(r"(?m)^import\s+\S+[ \t]*$")
OPEN_NS = re.compile(r"(?m)^open\s+(?!scoped\b)(.+)$")
NAMESPACE = re.compile(r"(?m)^namespace\s+(\S+)")
LEAF = re.compile(r"-- Generated from (\S+)\.lean")
TOKEN = re.compile(r"\b([a-zA-Z_][A-Za-z0-9_']*)\b")
LINE_COMMENT = re.compile(r"(?m)--.*$")
BLOCK_COMMENT = re.compile(r"/-.*?-/", re.S)
BINDERS = re.compile(
    r"(?ms)^\s*(?:noncomputable\s+|private\s+|protected\s+)*"
    r"(?:theorem|lemma|def|abbrev|structure|instance|class)\s+[\w.']+\s*(.*?)\s*:\s*(?:=|by|where)")

STOP = {
    "import", "namespace", "end", "variable", "theorem", "def", "abbrev",
    "structure", "inductive", "class", "instance", "lemma", "noncomputable",
    "section", "open", "by", "fun", "let", "have", "show", "exact", "rw",
    "simp", "intro", "apply", "refine", "constructor", "simpa", "using",
    "where", "then", "else", "if", "match", "with", "deriving", "attribute",
    "scoped", "notation", "infix", "prefix", "postfix", "macro", "syntax",
    "elab", "Prop", "Type", "Sort", "True", "False", "and", "or", "not",
    "iff", "forall", "exists", "Nat", "Int", "Real", "Complex", "Set",
    "Finset", "List", "Fin", "Function", "Submodule", "Continuous", "Dense",
    "IsClosed", "MvPolynomial", "EuclideanSpace", "norm", "inner", "Measure",
    "volume", "Lp", "map", "comp", "id", "prod", "sum", "of", "sorry",
}


def strip_comments(txt):
    return LINE_COMMENT.sub("", BLOCK_COMMENT.sub("", txt))


DECL_LINE = re.compile(
    r"^(?:noncomputable\s+|private\s+|protected\s+|@\[[^\]]*\]\s*)*"
    r"(?:def|abbrev|theorem|lemma|structure|inductive|class|instance)\s+"
    r"([A-Za-z_][A-Za-z0-9_'.]*)")
NS_LINE = re.compile(r"^namespace\s+(\S+)")
SECTION_LINE = re.compile(r"^(?:noncomputable\s+)?section\b")
END_LINE = re.compile(r"^end\b")


def declarations_with_ns(txt):
    """(short name, enclosing namespace) for every declaration in a module.

    A `Def_` bundle declares its contents *inside* `namespace BookProof.X`, so
    the namespace has to come from the scope stack.  A stub declares fully
    qualified names at the root instead (`theorem BookProof.ChapterH9.foo`), and
    those carry their own prefix.  `section`/`end` share the same `end` keyword
    as `namespace`, so both are tracked on the stack and popped together."""
    stack, out = [], []
    for line in txt.split("\n"):
        # Scope openers/closers are written at column 0; an indented `end` belongs
        # to a tactic block (match/induction arms), and letting those pop the
        # stack is what produced namespaces like `open None.BookProof.X`.
        if line[:1].isspace():
            continue
        m = NS_LINE.match(line)
        if m:
            nm = m.group(1)
            # A dotted `namespace A.B` is written absolutely throughout this
            # workspace; only a bare name (`namespace FormDom` inside
            # `namespace BookProof.FriedrichsExtension`) is relative.  Prepending
            # the parent unconditionally produced names like
            # `BookProof.X.BookProof.X.CertInterval`.
            if "." not in nm and not nm.startswith("_root_"):
                parent = next((x for x in reversed(stack) if x), None)
                if parent:
                    nm = f"{parent}.{nm}"
            stack.append(nm.lstrip("_root_."))
            continue
        if SECTION_LINE.match(line):
            stack.append(None)
            continue
        if END_LINE.match(line):
            if stack:
                stack.pop()
            continue
        m = DECL_LINE.match(line)
        if not m:
            continue
        name = m.group(1)
        if "." in name:
            out.append((name.split(".")[-1], name.rsplit(".", 1)[0]))
        else:
            out.append((name, ".".join(x for x in stack if x)))
    return out


# Every namespace some project module declares: `open` on anything else is an
# error in Lean, so an open is only ever emitted for a name in here.
KNOWN_NS = set()


def build_index():
    """name -> sorted list of (module, namespace); plus each module's deps."""
    providers, imports_of = {}, {}
    for root in ("Definitions", "Theorems"):
        d = os.path.join(WS, root)
        if not os.path.isdir(d):
            continue
        for fn in sorted(os.listdir(d)):
            if not fn.endswith(".lean"):
                continue
            mod = f"{root}.{fn[:-len('.lean')]}"
            txt = strip_comments(open(os.path.join(d, fn), encoding="utf-8").read())
            imports_of[mod] = set(IMPORT.findall(txt))
            for short, ns in declarations_with_ns(txt):
                pair = (mod, ns)
                if pair not in providers.setdefault(short, []):
                    providers[short].append(pair)
                if ns:
                    KNOWN_NS.add(ns)
    for v in providers.values():
        v.sort()
    return providers, imports_of


def reachable(mod, imports_of, seen):
    for dep in imports_of.get(mod, ()):
        if dep not in seen:
            seen.add(dep)
            reachable(dep, imports_of, seen)
    return seen


def source_opens(leaf):
    path = os.path.join(WS, "BookProof", f"{leaf}.lean")
    if not os.path.exists(path):
        return set()
    nss = set()
    for line in OPEN_NS.findall(open(path, encoding="utf-8").read()):
        nss.update(t for t in line.split() if t.startswith("BookProof"))
    return nss


def repair(path, providers, imports_of, dry_run=False):
    raw = open(path, encoding="utf-8").read()
    txt = strip_comments(raw)
    m = LEAF.search(raw)
    if m:
        leaf = m.group(1)
    elif os.path.basename(path).startswith("Def_"):
        # Def bundles carry no generated-from header: their source is the same
        # chapter, named by the file (`Def_<leaf>.lean` -> `BookProof/<leaf>.lean`).
        leaf = os.path.basename(path)[len("Def_"):-len(".lean")]
    else:
        return [], [], []
    src_opens = source_opens(leaf)

    reach = set(IMPORT.findall(txt))
    for dep in list(reach):
        reachable(dep, imports_of, reach)

    have_imports = set(IMPORT.findall(txt))
    have_opens = set()
    for line in OPEN_NS.findall(txt):
        have_opens.update(line.split())

    def resolves(prov):
        """A name is usable unqualified only when its module is reachable *and*
        its namespace is opened here (declarations at the root need no open).
        Reachability alone is not enough: `Vd` sits in `BookProof.HermiteProductCore`,
        which this bundle reaches through `HermiteProductBasis` but never opens —
        which is precisely why the platform said `Unknown identifier Vd`."""
        mod, ns = prov
        return mod in reach and (not ns or ns in have_opens)

    # Names bound by this file itself: its own binders and its declared target.
    bound = set()
    for b in BINDERS.findall(txt):
        for grp in re.finditer(r"[\(\{\[]([^\(\)\{\}\[\]]*)[\)\}\]]", b):
            # Only the segment before the first `:` holds binder *names*;
            # everything after it is the type, and pulling identifiers out of
            # the type marks cited definitions as bound (`(x : Vd d)` would
            # otherwise report `Vd` as locally bound).
            bound.update(TOKEN.findall(grp.group(1).split(":")[0]))
    hdr = re.search(r"(?:solution of|theorem)\s+([A-Za-z0-9_.']+)", raw)
    if hdr:
        bound.add(hdr.group(1).split(".")[-1])
    # A file's own declarations are obviously not missing: a Def bundle names its
    # own contents, and without this it reports every one of them as unresolved.
    bound |= {short for short, _ in declarations_with_ns(txt)}

    add_imports, add_opens, unresolved = [], [], []
    # Two-character names matter: `Vd` (EuclideanSpace) is exactly the kind of
    # abbreviation a def body cites, and filtering it out silently missed it.
    for name in sorted({t for t in TOKEN.findall(txt) if len(t) >= 2 and t not in STOP}):
        if name in bound:
            continue
        provs = providers.get(name)
        if not provs or any(resolves(p) for p in provs):
            continue
        # Only a provider whose namespace the *source chapter* opens puts the
        # name in scope unqualified there.  Anything else is a coincidence, and
        # guessing is worse than not patching: a wrong `open` is a compile error
        # that costs one of the five attempts.  So this fails closed.
        pick = [p for p in provs if p[1] and p[1] in src_opens and p[1] in KNOWN_NS]
        if not pick:
            unresolved.append((name, provs))
            continue
        mod, ns = pick[0]
        if mod not in reach and mod not in add_imports:
            add_imports.append(mod)
        if ns not in have_opens and ns not in add_opens:
            add_opens.append(ns)

    if not add_imports and not add_opens:
        return [], [], unresolved
    if not dry_run:
        lines = raw.split("\n")
        if add_imports:
            at = max(i for i, ln in enumerate(lines) if ln.startswith("import "))
            lines[at + 1:at + 1] = [f"import {d}" for d in sorted(add_imports)]
        if add_opens:
            rows = [i for i, ln in enumerate(lines) if ln.startswith("open ")]
            at = rows[-1] if rows else len(lines) - 1
            lines[at + 1:at + 1] = [f"open {ns}" for ns in add_opens]
        open(path, "w", encoding="utf-8").write("\n".join(lines))
    return (sorted(add_imports), add_opens, unresolved)


def main():
    argv = sys.argv[1:]
    dry = "--dry-run" in argv
    positional = [a for a in argv if not a.startswith("--")]
    if "--pending-thms" in argv:
        sys.path.insert(0, os.path.join(WS, "pipeline"))
        import upload_pipeline as U
        st = U.load_state()
        miss = U.missing_sources()
        files = []
        for item, rec in st["items"].items():
            if not item.startswith("thm:") or rec.get("status") == "done":
                continue
            slug = item.split(":", 1)[1]
            if slug in miss:
                continue
            p = os.path.join(WS, "Theorems", f"Thm_{slug}.lean")
            if os.path.exists(p):
                files.append(p)
        files.sort()
    elif "--all" in argv:
        files = sorted(glob.glob(os.path.join(WS, "Theorems", "Thm_*.lean")) +
                       glob.glob(os.path.join(WS, "Solutions", "Sol_*.lean")) +
                       glob.glob(os.path.join(WS, "Definitions", "Def_*.lean")))
    else:
        files = []
        for a in positional:
            files += sorted(glob.glob(a if os.path.isabs(a) else os.path.join(WS, a)))

    providers, imports_of = build_index()
    patched = blocked = 0
    for path in files:
        add_imports, add_opens, unresolved = repair(path, providers, imports_of, dry_run=dry)
        if not add_imports and not add_opens and not unresolved:
            continue
        if add_imports or add_opens:
            patched += 1
            print(os.path.basename(path))
            for d in add_imports:
                print(f"    + import {d}")
            if add_opens:
                print(f"    + open {' '.join(add_opens)}")
        for name, provs in unresolved:
            blocked += 1
            print(f"    ? {os.path.basename(path)}: `{name}` declared only in "
                  f"{', '.join(m for m, _ in provs)} — namespace not opened by the source")
    print(f"\n{len(files)} file(s): {patched} patched, {blocked} unresolved"
          + (" [dry run]" if dry else ""))
    return 0


if __name__ == "__main__":
    sys.exit(main())
