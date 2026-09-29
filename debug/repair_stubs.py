#!/usr/bin/env python3
"""Repair the generated `Theorems/` stubs that cannot publish as written.

Three failure classes show up when the extended wave submits (see
PIPELINE_PLAN.md §1c). This fixes the two that are mechanical:

  * **unknown namespace** — the stub carries `open BookProof.X` lines its single
    `import Definitions.Def_<own chapter>` cannot satisfy.  Two remedies, in
    preference order: add `import Definitions.Def_<chapter>` for a *published*
    bundle that declares X (the open then resolves), else drop the offending
    `open` line (it can never resolve, and an unresolvable open is a hard
    compile error before the statement is even read).
  * **already declared** — the stub's declaration was *embedded* into its own
    def bundle by the §5a repairs, so a separate node is a duplicate by
    construction.  Those slugs are dropped from `pipeline/wave_upload.json`
    (together with their `sol_order` entries) instead of burning 5 attempts to
    learn the same thing.

The third class ("unknown identifier": the statement cites a helper that lives
in the source chapter but in no published module) is *not* touched — those are
resolved by publishing the helper's own node first, which the reader can do by
walking ORDER.

Usage:
  python3 debug/repair_stubs.py --dry-run [--limit N]
  python3 debug/repair_stubs.py
"""
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(WS, "pipeline"))

SPEC = os.path.join(WS, "pipeline", "wave_upload.json")
DEF_IMPORT = re.compile(r"(?m)^import\s+Definitions\.Def_(\S+)")
OPEN_LINE = re.compile(r"(?m)^open\s+(.+?)\s*$")
NS_DECL = re.compile(r"(?m)^namespace\s+([\w.]+)\s*$")
DECL_ANY = re.compile(
    r"(?m)^\s*(?:noncomputable\s+|private\s+|protected\s+|@\[[^\]]*\]\s*)*"
    r"(?:def|abbrev|theorem|lemma|structure|inductive|class|instance)\s+"
    r"([A-Za-z_][A-Za-z0-9_'.]*)")


def published_defs(state):
    return {k[4:] for k, v in state["items"].items()
            if k.startswith("def:") and v.get("status") == "done"}


def bundle_info(chapter):
    """(namespaces declared, short names declared) of one def bundle.

    Nested `namespace A` / `namespace B` blocks are composed into `A.B` (the
    flat regex misses that, and the miss shows up as a bogus "unknown
    namespace"), and every namespace on the path is recorded.
    """
    path = os.path.join(WS, "Definitions", f"Def_{chapter}.lean")
    if not os.path.exists(path):
        return set(), set()
    txt = open(path, encoding="utf-8", errors="replace").read()
    nss, names, stack = set(), set(), []
    for line in txt.split("\n"):
        m = NS_DECL.match(line.strip())
        if m:
            for part in m.group(1).split("."):
                stack.append(part)
                nss.add(".".join(stack))
            continue
        m = re.match(r"^end(?:\s+([\w.]+))?\s*$", line.strip())
        if m and stack:
            seg = m.group(1) or ""
            if seg:
                parts = seg.split(".")
                for k in range(len(parts), 0, -1):
                    if stack[-k:] == parts[:k]:
                        del stack[len(stack) - k:]
                        break
            else:
                stack.pop()
            continue
        for d in DECL_ANY.findall(line):
            names.add(d.split(".")[-1])
    return nss, names


def bundle_imports(chapter):
    path = os.path.join(WS, "Definitions", f"Def_{chapter}.lean")
    if not os.path.exists(path):
        return set()
    txt = open(path, encoding="utf-8", errors="replace").read()
    return set(DEF_IMPORT.findall(txt))


def main():
    argv = sys.argv[1:]
    dry = "--dry-run" in argv
    limit = 0
    if "--limit" in argv:
        i = argv.index("--limit")
        limit = int(argv[i + 1])

    spec = json.load(open(SPEC, encoding="utf-8"))
    state = json.load(open(os.path.join(WS, "state", "pipeline.json")))
    pub = published_defs(state)

    # namespaces declared anywhere reachable from a def bundle (transitive over
    # its own Definitions imports) — what a stub importing it can actually open.
    ns_cache = {}

    def reachable_ns(chapter, seen=None):
        if chapter in ns_cache:
            return ns_cache[chapter]
        seen = seen or set()
        if chapter in seen:
            return set()
        seen.add(chapter)
        nss, _ = bundle_info(chapter)
        for dep in bundle_imports(chapter):
            if dep.startswith("Chapter"):
                nss |= reachable_ns(dep, seen)
        ns_cache[chapter] = nss
        return nss

    owner = {}                      # namespace -> chapter that declares it
    for ch in pub:
        for ns in reachable_ns(ch):
            owner.setdefault(ns, ch)

    dropped, patched, skipped = [], [], []
    for slug, meta in sorted(spec["thms"].items()):
        path = os.path.join(WS, "Theorems", f"Thm_{slug}.lean")
        if not os.path.exists(path):
            continue
        txt = open(path, encoding="utf-8", errors="replace").read()
        deps = DEF_IMPORT.findall(txt)
        own = deps[0] if deps else None
        if not own:
            skipped.append((slug, "no Definitions import"))
            continue
        # Never touch a stub whose node is already published: its statement is
        # what the platform holds, and the file's shape is no longer relevant.
        if (state["items"].get("thm:" + slug) or {}).get("status") == "done":
            continue
        short = meta["name"].split(".")[-1]
        _, names = bundle_info(own)
        if short in names:
            dropped.append((slug, f"declared inside Def_{own} (embedded by §5a)"))
            continue
        avail = set(reachable_ns(own))
        add_imports, strip_opens = set(), []
        for m in OPEN_LINE.finditer(txt):
            for ns in m.group(1).split():
                if not ns.startswith("BookProof") or ns in avail:
                    continue
                prov = owner.get(ns)
                if prov and prov != own:
                    add_imports.add(prov)
                    avail |= reachable_ns(prov)      # its closure comes along
                else:
                    strip_opens.append(ns)
        if not add_imports and not strip_opens:
            continue
        patched.append((slug, sorted(add_imports), strip_opens))
        if limit and len(patched) >= limit:
            break

    print(f"wave thms: {len(spec['thms'])}  |  duplicates to drop: {len(dropped)}  "
          f"|  stubs to rewrite: {len(patched)}  |  untouched oddities: {len(skipped)}")
    for slug, why in dropped[:8]:
        print(f"  DROP {slug}: {why}")
    for slug, adds, strips in patched[:8]:
        print(f"  FIX  {slug}: +import {adds or '-'}  -open {strips or '-'}")

    if dry:
        print("[dry run] nothing written")
        return 0

    drop_set = {s for s, _ in dropped}
    for slug, adds, strips in patched:
        path = os.path.join(WS, "Theorems", f"Thm_{slug}.lean")
        lines = open(path, encoding="utf-8", errors="replace").read().split("\n")
        if strips:
            keep, have_open = [], set()
            for ln in lines:
                m = re.match(r"^open\s+(.+?)\s*$", ln)
                if m:
                    names = m.group(1).split()
                    left = [n for n in names if n not in strips]
                    if not left:
                        continue
                    ln = "open " + " ".join(left)
                keep.append(ln)
            lines = keep
        if adds:
            last = max(i for i, ln in enumerate(lines) if ln.startswith("import "))
            lines[last + 1:last + 1] = [f"import Definitions.Def_{c}" for c in sorted(adds)]
        open(path, "w", encoding="utf-8").write("\n".join(lines))

    if drop_set:
        for s in drop_set:
            spec["thms"].pop(s, None)
        spec["sol_order"] = [s for s in spec["sol_order"] if s not in drop_set]
        with open(SPEC, "w", encoding="utf-8") as f:
            json.dump(spec, f, indent=1)

    print(f"wrote {len(patched)} stub(s); spec now {len(spec['defs'])} defs / "
          f"{len(spec['thms'])} thms / {len(spec['sol_order'])} sol slugs")
    return 0


if __name__ == "__main__":
    sys.exit(main())
