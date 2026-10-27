#!/usr/bin/env python3
"""Reconstruct a def bundle as: platform-published base + local-only decls.

For bundles whose local text was damaged by bad edits (deleted structure/
namespace headers, interleaved garbage) while the platform still holds a
known-good published copy: start from the published `definition` text and
graft back only the declarations the local text added beyond it (those are
what downstream stubs/sols reference).

Steps:
  1. fetch the published definition text for <Chapter> via the jobs catalogue
  2. decl-diff local vs published (namespace-aware, unicode-subscript aware)
  3. graft each local-only decl block (attrs/docs included, clamped at
     namespace/end lines) into the published base before the matching `end`
  4. write the assembled file back over Definitions/Def_<Chapter>.lean
  5. compile it against the candidate mirror (LEAN_PATH candidate:base)

Usage:
  python3 debug/assemble_published_base.py ChapterNavierStokesShiftHamiltonian [--no-write]
"""
import argparse
import bisect
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
sys.path.insert(0, os.path.join(WS, "debug"))

import upload_pipeline as up  # noqa: E402

DECL = re.compile(
    r'^\s*(?:@\[[^\]]*\]\s*)?(?:protected\s+|noncomputable\s+)?'
    r'(def|theorem|lemma|abbrev|structure|inductive|class|instance)\s+'
    r"([A-Za-z0-9_\'\.①-⑳¹-⁰₀-₉]+)", re.M)
NSRE = re.compile(r'^(namespace|end)\b\s*([A-Za-z0-9_.\']+)?', re.M)
SEND = re.compile(r'^(namespace|end)\b')


def ns_map(txt):
    spans, stack = [], []
    for m in NSRE.finditer(txt):
        if m.group(1) == 'namespace':
            stack.append(m.group(2) or '')
        elif stack:
            stack.pop()
        spans.append((m.start(), '.'.join(x for x in stack if x)))

    def ns_at(pos):
        cur = ''
        for s, n in spans:
            if s <= pos:
                cur = n
            else:
                break
        return cur
    return ns_at


def decl_list(txt):
    ns_at = ns_map(txt)
    out = []
    for m in DECL.finditer(txt):
        ns = ns_at(m.start())
        bare = m.group(2)
        full = f"{ns}.{bare}" if ns and '.' not in bare else bare
        out.append((m, full))
    return out


def assemble(chapter, write=True):
    local_path = os.path.join(WS, "Definitions", f"Def_{chapter}.lean")
    local = open(local_path, encoding="utf-8").read()
    tid = up._find_definition_node(chapter)
    if not tid:
        # Fallback 1: the ledger's recorded def_id for this chapter.
        try:
            st = json.load(open(os.path.join(WS, "state", "pipeline.json")))
            tid = (st["items"].get(f"def:{chapter}") or {}).get("def_id")
        except (OSError, KeyError, ValueError):
            tid = None
    if not tid:
        # Fallback 2: the definition publish-job catalogue.
        j = (up.platform_jobs() or {}).get(chapter) or {}
        if j.get("kind") == "definition" and j.get("status") == "PUBLISHED":
            tid = j.get("theorem_id")
    if not tid:
        print(f"{chapter}: no published definition node found -- abort")
        return 1
    rec = up.api("GET", f"theorems/{tid}") or {}
    pub = rec.get("definition") or ""
    if not pub.strip():
        print(f"{chapter}: published definition text empty -- abort")
        return 1

    # Compare on BARE decl names: damaged local files may have flattened
    # namespace wrappers (namespace shift), so full keys of shared decls can
    # differ between local and published while the decls are identical.
    # A false "local-only" here duplicates a published decl (compile error
    # `has already been declared` at the graft site).
    pub_names = {n.rsplit('.', 1)[-1] for _, n in decl_list(pub)}
    local_decls = decl_list(local)
    graft_names = {n for _, n in local_decls
                   if n.rsplit('.', 1)[-1] not in pub_names}
    print(f"{chapter}: local-only decls: {len(graft_names)}")
    for n in sorted(graft_names):
        print("   ", n)
    if not graft_names:
        print("  nothing to graft; published text already covers local decls")

    lines = local.splitlines(keepends=True)
    offs = [0]
    for l in lines:
        offs.append(offs[-1] + len(l))
    starts, ns_ends = [], []
    for m, name in local_decls:
        ln = bisect.bisect_right(offs, m.start()) - 1
        s = ln
        while s - 1 >= 0:
            if DECL.match(lines[s - 1]):
                break
            t = lines[s - 1].rstrip('\n').strip()
            if (t == '' or t.startswith('--') or t.startswith('/-')
                    or t.startswith('@[') or t.startswith('set_option')
                    or t.endswith(' in')):
                s -= 1
                continue
            break
        starts.append(offs[s])
        e = ln
        while e < len(lines) and not SEND.match(lines[e]):
            e += 1
        ns_ends.append(offs[e] if e < len(lines) else len(local))

    blocks = []
    for i, (m, name) in enumerate(local_decls):
        b = starts[i + 1] if i + 1 < len(local_decls) else len(local)
        blocks.append((name, starts[i], min(b, ns_ends[i])))

    # group each graft by the published namespace it must land in: use the
    # LOCAL namespace of the decl, and find that namespace's LAST `end` in pub
    local_ns = {n: ns_map(local)(m.start()) for m, n in local_decls}
    groups = {}
    for name, a, b in blocks:
        if name not in graft_names:
            continue
        ns = local_ns[name]
        groups.setdefault(ns, []).append(local[a:b])

    out = pub
    for ns, chunks in groups.items():
        marker = f"\nend {ns.split('.')[-1]}\n" if ns else None
        # published file namespaces may be nested `namespace A.B`; find the end
        # matching by trying full then bare forms
        idx = -1
        for cand in (f"\nend {ns}\n", marker):
            if cand:
                idx = out.rfind(cand)
                if idx != -1:
                    break
        if idx == -1:
            print(f"  WARNING: no end marker found for namespace {ns}; "
                  f"grafts of {len(chunks)} decls skipped")
            continue
        out = out[:idx] + '\n' + ''.join(chunks) + out[idx:]

    print(f"assembled: {len(out.splitlines())} lines "
          f"(published {len(pub.splitlines())}, local {len(local.splitlines())})")
    if write:
        open(local_path, 'w', encoding='utf-8').write(out)
        print("wrote", local_path)
    return 0


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("chapter")
    ap.add_argument("--no-write", action="store_true")
    a = ap.parse_args()
    sys.exit(assemble(a.chapter, write=not a.no_write))
