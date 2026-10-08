#!/usr/bin/env python3
"""Find Lean files whose block-comment fences do not balance to depth 0.

A stray `-/` (final depth < 0) or an unclosed `/-` (depth > 0) almost always
means an earlier bulk edit spliced a duplicated region mid-file -- e.g.
Def_ChapterNavierStokesHashimoto had a whole body copy inserted with its
opening `/-!` lost, leaving bare prose at top level ("unexpected identifier;
expected command").

Usage: python3 debug/check_comment_depth.py [--dir Definitions] [--dir Theorems]
"""
import os
import sys

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()


def depth_of(path):
    depth = 0
    neg = []
    txt = open(path, encoding="utf-8", errors="ignore").read()
    i = 0
    line = 1
    while i < len(txt) - 1:
        two = txt[i:i + 2]
        if two == "/-":
            depth += 1
            i += 2
            continue
        if two == "-/":
            depth -= 1
            if depth < 0 and not neg:
                neg.append(line)
            depth = max(depth, -1)  # keep counting, note first offense
            i += 2
            continue
        if txt[i] == "\n":
            line += 1
        i += 1
    return depth, neg


def main():
    dirs = [d for d in sys.argv[1:] if not d.startswith("-")] or \
        ["Definitions", "Theorems", "Solutions"]
    bad = 0
    for d in dirs:
        root = os.path.join(WS, d)
        if not os.path.isdir(root):
            continue
        for f in sorted(os.listdir(root)):
            if not f.endswith(".lean"):
                continue
            depth, neg = depth_of(os.path.join(root, f))
            if depth != 0 or neg:
                bad += 1
                print(f"{d}/{f}: final_depth={depth} first_stray_close_at={neg}")
    print(f"\n{bad} file(s) with unbalanced fences")


if __name__ == "__main__":
    main()
