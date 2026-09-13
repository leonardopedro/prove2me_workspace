#!/usr/bin/env python3
"""Add the generated `Theorems/` stubs that are missing from the wave spec.

`pipeline/wave_upload.json` was assembled from one generator batch's manifest,
but the checkout holds many more generated stubs.  A stub is publishable when

  * its `import Definitions.Def_<chapter>` target is PUBLISHED on the platform
    (a thm stub compiles nowhere else), and
  * for the sol side, `Solutions/Sol_<slug>.lean` exists.

Metadata (title / nl / source) is rebuilt exactly the way the original
generator built it: the declaration's docstring is sliced out of the SOURCE
chapter (`BookProof/Chapter<leaf>.lean`) at the byte offsets recorded in
`state/sketch/sketch_<leaf>.jsonl`, and the line-linked source anchor comes from
the same record.  Nothing is invented when a docstring exists.

Append-only: existing def/thm entries and the existing `sol_order` prefix are
never rewritten or removed.  New thm slugs are appended to `sol_order` after a
topological sort of the batch (a solution that imports a sibling stub's theorem
must come after it), which is also the order the uploader walks them in.

Usage:
  python3 debug/extend_wave_stubs.py [--dry-run] [--limit N]
                                     [--chapter ChapterX ...]
"""
import glob
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(WS, "pipeline"))

CANON = "/home/leo/prove2me_workspace"   # canonical absolute root in the spec
REPO = "https://github.com/leonardopedro/timepiece/blob/61595bc"
SPEC = os.path.join(WS, "pipeline", "wave_upload.json")
SKETCH = os.path.join(WS, "state", "sketch")

GEN_COMMENT = re.compile(r"^--\s*Generated from (\S+?)\.lean\s*[—-]\s*theorem\s+(\S+)", re.M)
DEF_IMPORT = re.compile(r"(?m)^import\s+Definitions\.Def_(\S+)")
DECL = re.compile(r"(?m)^theorem\s+([A-Za-z_][A-Za-z0-9_'.]*)")
DOC_OPEN = re.compile(r"^/--\s?")
FENCE = re.compile(r"^```.*$", re.M)


def clamp_title(s, cap=200):
    """Titles are capped at 200 *bytes* (the server counts UTF-8), clipped at a
    word boundary without splitting a character."""
    b = s.encode("utf-8")
    if len(b) <= cap:
        return s
    cut = b[:cap].decode("utf-8", "ignore")
    if " " in cut:
        cut = cut[:cut.rfind(" ")]
    return cut.strip()


def prose(doc):
    """Docstring text -> prose: drop the delimiters and the markdown structure,
    keeping paragraph breaks (same normalisation the wave spec uses)."""
    if not doc:
        return ""
    txt = doc.strip()
    txt = DOC_OPEN.sub("", txt)
    txt = re.sub(r"-/\s*$", "", txt)
    txt = FENCE.sub("", txt)
    paras = []
    for p in re.split(r"\n\s*\n", txt):
        p = re.sub(r"\s+", " ", p).strip()
        p = p.lstrip("#").strip()
        if p:
            paras.append(p)
    return paras


def source_docstring(leaf, short):
    """(docstring, declStartLine, declEndLine) for `short` in the source chapter."""
    path = os.path.join(WS, "BookProof", f"Chapter{leaf}.lean")
    spath = os.path.join(SKETCH, f"sketch_{leaf}.jsonl")
    if not (os.path.exists(path) and os.path.exists(spath)):
        return None, None, None
    txt = open(path, encoding="utf-8", errors="replace").read()
    rec = None
    with open(spath, encoding="utf-8", errors="replace") as f:
        for line in f:
            try:
                d = json.loads(line)
            except ValueError:
                continue
            if d.get("nameText") == short:
                rec = d
                break
    if not rec:
        return None, None, None
    doc = None
    ds = rec.get("docstring")
    if ds:
        doc = txt[ds["start"]["offset"]:ds["end"]["offset"]]
    start = (rec.get("declStart") or {}).get("line")
    end = (rec.get("declEnd") or {}).get("line")
    return doc, start, end


def chapter_tags(spec, leaf):
    """Reuse the tags an already-published node from the same chapter carries."""
    for m in spec["thms"].values():
        if m.get("chapter") == leaf:
            return list(m.get("tags") or ["timepiece"])
    return ["timepiece"]


def published_defs():
    """Def bundles the platform already holds (authoritative; state can be stale)."""
    try:
        import upload_pipeline as U
        return {n for n, j in U.platform_jobs().items()
                if j.get("kind") == "definition" and j.get("status") == "PUBLISHED"}
    except Exception as e:                                   # offline fallback
        print(f"  (platform read failed: {type(e).__name__}: {e}; using local state)")
        st = json.load(open(os.path.join(WS, "state", "pipeline.json")))["items"]
        return {k[4:] for k, v in st.items()
                if k.startswith("def:") and v.get("status") == "done"}


def main():
    argv = sys.argv[1:]
    dry = "--dry-run" in argv
    argv = [a for a in argv if a != "--dry-run"]
    limit = 0
    if "--limit" in argv:
        i = argv.index("--limit")
        limit = int(argv[i + 1])
        del argv[i:i + 2]
    only = []
    if "--chapter" in argv:
        i = argv.index("--chapter")
        only = argv[i + 1:]
        del argv[i:]

    spec = json.load(open(SPEC, encoding="utf-8"))
    have = set(spec["thms"])
    pub = published_defs()
    sols = {os.path.basename(p)[4:-5]: p
            for p in glob.glob(os.path.join(WS, "Solutions", "Sol_BookProof_*.lean"))}

    added = []
    skipped_nosol = []
    for path in sorted(glob.glob(os.path.join(WS, "Theorems", "Thm_BookProof_*.lean"))):
        slug = os.path.basename(path)[4:-5]
        if slug in have:
            continue
        txt = open(path, encoding="utf-8", errors="replace").read()
        g = GEN_COMMENT.search(txt)
        imports = DEF_IMPORT.findall(txt)
        if g:
            leaf, name = g.group(1), g.group(2)
        else:
            decls = DECL.findall(txt)
            if not decls or not imports:
                continue
            leaf, name = imports[0], decls[0]
        # The chapter name always carries the `Chapter` prefix (it is the
        # platform's `definition_name`); `stem` is the module/namespace stem.
        if not leaf.startswith("Chapter"):
            leaf = "Chapter" + leaf
        stem = leaf[len("Chapter"):]
        if only and stem not in only and leaf not in only:
            continue
        if leaf not in pub:
            continue                                   # chapter's def bundle is not live
        short = name.split(".")[-1]
        if slug not in sols:
            skipped_nosol.append(slug)
            continue
        doc, l0, l1 = source_docstring(stem, short)
        paras = prose(doc)
        if paras:
            title = paras[0]
            body = "\n\n".join(paras)
        else:
            title = (f"The Lean 4 theorem `{short}` in the `{leaf}` chapter of "
                     f"the timepiece formalization")
            body = title + "."
        anchor = (f"#L{l0}-L{l1}" if l0 and l1 else "")
        nl = (f"{body}\n\n\n\n**Formalization Note.** Lean 4 identifier: `{name}` "
              f"(module `BookProof.{stem}`), line-linked source: "
              f"`{leaf}.lean` lines {l0}–{l1}." if l0 and l1 else body)
        if len(nl) > 4000:
            nl = nl[:4000].rstrip() + "\n\n..."
        added.append((slug, {
            "name": name,
            "chapter": leaf,
            "file": f"{CANON}/Theorems/Thm_{slug}.lean",
            "title": clamp_title(title),
            "nl": nl,
            "source": f"{REPO}/BookProof/{leaf}.lean{anchor}",
            "tags": chapter_tags(spec, leaf),
        }))
        if limit and len(added) >= limit:
            break

    if not added:
        print("nothing to add (every publishable stub is already in the wave spec)")
        return 0

    # Topological order inside the batch: a sol that imports a sibling stub's
    # theorem must be uploaded after it.
    batch = {s for s, _ in added}
    indeg = {s: 0 for s in batch}
    adj = {s: set() for s in batch}
    for s, _ in added:
        for dep in re.findall(r"(?m)^import\s+Theorems\.Thm_(\S+)",
                              open(sols[s], encoding="utf-8", errors="replace").read()):
            if dep in batch and dep != s:
                adj[dep].add(s)
                indeg[s] += 1
    order, q = [], sorted(s for s in batch if indeg[s] == 0)
    while q:
        s = q.pop(0)
        order.append(s)
        for m in sorted(adj[s]):
            indeg[m] -= 1
            if indeg[m] == 0:
                q.append(m)
    order += sorted(batch - set(order))                # cycle guard: keep every slug

    print(f"adding {len(added)} thm entries + {len(order)} sol_order slugs")
    if skipped_nosol:
        print(f"  ({len(skipped_nosol)} of the publishable stubs have no solution file "
              f"and were left out, e.g. {skipped_nosol[:3]})")
    for s, m in added[:5]:
        print(f"  {s}\n      name : {m['name']}\n      title: {m['title'][:110]}"
              f"\n      src  : {m['source']}")
    if dry:
        print("[dry run] spec not written")
        return 0

    for s, m in added:
        spec["thms"][s] = m
    spec["sol_order"].extend(order)
    with open(SPEC, "w", encoding="utf-8") as f:
        json.dump(spec, f, indent=1)
    print(f"wrote {SPEC}: {len(spec['defs'])} defs, {len(spec['thms'])} thms, "
          f"{len(spec['sol_order'])} sol_order")
    return 0


if __name__ == "__main__":
    sys.exit(main())
