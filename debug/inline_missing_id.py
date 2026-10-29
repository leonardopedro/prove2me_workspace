#!/usr/bin/env python3
"""Inline a helper declaration from a workspace `Definitions/Def_*` bundle into a sol.

Why: §2.67 — the PUBLISHED text of a def bundle is partial (the generator
dropped decls), while the workspace text has them.  A sol whose proof calls one
of those dropped helpers fails server-side with `Unknown identifier X` even
though the sol already imports the (published) bundle.  No Thm node carries the
helper, so the content must reach the sol by being pasted in as a `private`
copy of the declaration (the same repair used for `Def_ChapterHermiteRelativeBound`
in §2.67: content reaches consumers through nodes that actually compile).

Safety rules:
  * the declaration is copied VERBATIM from the workspace Def text (proof and
    all) — nothing is re-proved by hand;
  * `def`/`lemma`/`theorem` becomes `private` so it cannot clash with a
    published twin of the same name, and `@[simp]` attributes are kept (they
    are what the proof's bare `simp` calls rely on);
  * enclosing `variable` binders actually used by the declaration are copied
    above it, so the copy elaborates in the sol's file scope;
  * the copy is inserted immediately before `theorem solution` and never
    replaces or shadows the sol's own statement.

Usage:
  python3 debug/inline_missing_id.py --plan /tmp/inline_plan.tsv   # slug\tid\tDefPath
  python3 debug/inline_missing_id.py <slug> <id> <DefPath>
"""
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

TOP = re.compile(
    r"^(theorem|lemma|def|abbrev|instance|structure|class|inductive|opaque|"
    r"example|section|namespace|end|variable|private|protected|local|open|"
    r"noncomputable|attribute|universe|macro|syntax|scoped|include|omit|"
    r"set_option|@\[|/\-|#|public\b)", re.M)

DECL = re.compile(
    r"^(?P<attrs>(?:@\[[^\]]*\]\s*)*)(?P<mods>(?:private\s+|protected\s+|"
    r"noncomputable\s+)*)(?P<kind>def|lemma|theorem|abbrev)\s+"
    r"(?P<name>[A-Za-z0-9_.'\u1d4a-\u1d7f]+)", re.M)


def active_variables(txt, pos):
    """`variable` commands in effect at `pos` (since the last `namespace`/`section`)."""
    out = []
    for m in re.finditer(r"^(variable|section|namespace|end)\b[^\n]*", txt, re.M):
        if m.start() >= pos:
            break
        line = m.group(0)
        if line.startswith("variable"):
            out.append(line)
        elif line.startswith(("section", "namespace")):
            out = []
    return out


def uses(name, text):
    return re.search(rf"(?<![\w'.]){re.escape(name)}(?![\w'])", text) is not None


def extract(defpath, name):
    txt = open(defpath, encoding="utf-8").read()
    m = None
    for cand in DECL.finditer(txt):
        if cand.group("name").split(".")[-1] == name:
            m = cand
            break
    if not m:
        return None
    e = TOP.search(txt, m.end())
    body = txt[m.start(): e.start() if e else len(txt)].rstrip()
    # drop the original modifier block (if any) and re-add `private` so the
    # copy can never clash with a published twin of the same name; attributes
    # are kept -- the proofs' bare `simp` calls rely on them.
    attrs = m.group("attrs").rstrip()
    if attrs and not attrs.endswith(" "):
        attrs += " "
    # rebuild from the DECL match: attrs + "private " + kind + name + rest
    rest = body[m.end() - m.start():]
    head = f"{attrs}private {m.group('kind')} {m.group('name')}{rest}"
    # collect variables the declaration text actually mentions
    vars_ = [v for v in active_variables(txt, m.start())
             if uses(_var_name(v), body)]
    return ("\n".join(vars_ + [""]) + head).rstrip() + "\n"


def _var_name(vline):
    m = re.match(r"variable\s+(?:\{|\(|\[[^\]]*\]\s*)?([A-Za-z0-9_']+)", vline.strip())
    return m.group(1) if m else ""


def apply(slug, ident, defpath):
    path = os.path.join(WS, "Solutions", f"Sol_{slug}.lean")
    if not os.path.exists(path):
        return f"missing sol {slug}"
    decl = extract(defpath, ident)
    if decl is None:
        return f"{ident} not found in {defpath}"
    src = open(path, encoding="utf-8").read()
    if re.search(rf"(?<![\w'.]){re.escape(ident)}\b(?![\w'])", src) is None:
        return f"{ident} not referenced by {slug} (no-op)"
    if re.search(rf"private\s+\w+\s+{re.escape(ident)}\b", src):
        return f"{ident} already inlined"
    # anchor at the ENCLOSING declaration of the first use, so a copy needed by
    # an early `private` helper never lands after that helper's own body
    # (measured: inserting between `:= by` and its proof splits the proof off)
    u = re.search(rf"(?<![\w'.]){re.escape(ident)}(?![\w'])", src)
    if u:
        anchor = None
        for tm in TOP.finditer(src, 0, u.start() + 1):
            anchor = tm.start()
        # a `set_option ... in` / `omit ... in` prefix is part of the NEXT
        # command: step back over any prefix lines sitting directly above the
        # anchor, or the copy would steal the prefix from its declaration
        while anchor is not None and anchor > 0:
            nl = src.rfind("\n", 0, anchor)
            if nl <= 0:
                break
            pstart = src.rfind("\n", 0, nl) + 1
            pline = src[pstart:nl]
            if pline.endswith(" in") and pline.startswith(
                    ("set_option ", "omit ", "noncomputable ")):
                anchor = pstart
            else:
                break
        pos = anchor if anchor is not None else u.start()
    else:
        m = re.search(r"^theorem solution\b", src, re.M)
        if not m:
            return "no `theorem solution` anchor"
        pos = m.start()
    new = src[:pos] + decl.rstrip() + "\n\n" + src[pos:]
    open(path, "w", encoding="utf-8").write(new)
    return None


def main(argv):
    if argv and argv[0] == "--plan":
        rows = [l.rstrip("\n").split("\t") for l in open(argv[1]) if l.strip()]
    else:
        rows = [argv[0:3]]
    bad = []
    for slug, ident, defpath in rows:
        err = apply(slug, ident, defpath)
        if err:
            bad.append((slug, ident, err))
            print(f"  SKIP {slug} {ident}: {err}")
        else:
            print(f"  inline {ident} -> {slug}", flush=True)
    print(f"\n{len(rows) - len(bad)}/{len(rows)} inlined")
    return 1 if bad else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
