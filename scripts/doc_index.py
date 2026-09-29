#!/usr/bin/env python3
"""Doc index + backlinks: renders DOC_INDEX.md (or a custom target) from the
repository's Markdown files, backed by a versioned JSON index.

Index semantics adapted from the `typos` note vault
(../typos/notes-core/src/index.rs, Apache-2.0):
  * full rebuild (`build_index`), incremental per-file update (`--file`),
  * links deduplicated by (source, target),
  * versioned JSON index with `generated_at` written under `state/`.

Usage:
    python3 scripts/doc_index.py                       # full rebuild
    python3 scripts/doc_index.py --file AGENTS.md      # incremental update
    python3 scripts/doc_index.py --check               # exit 1 if stale
    python3 scripts/doc_index.py --backlinks README.md # who links here / what it links
    python3 scripts/doc_index.py --search health       # title/path/heading/content search
    python3 scripts/doc_index.py --scan references \
        --out-md references/INDEX.md --out-json state/references_index.json

Query modes adapt typos notes-core `query.rs` (backlinks(), search()): the
stored index is preferred, falling back to an in-memory build, and queries
never write anything.

Exit codes: 0 ok / index fresh; 1 stale (`--check`) or I/O error.
"""
from __future__ import annotations

import argparse
import datetime
import json
import os
import re
import sys
import urllib.parse

VERSION = 1

# Build/regenerable dirs are never documentation.
EXCLUDE_DIRS = {
    ".git", ".lake", ".lake_bk", "node_modules", "_out", "target",
    "__pycache__", ".venv", "state", "dist", "build",
}

LINK_RE = re.compile(r"!?\[[^\]]*\]\(\s*([^)\s]+)\)")
HEADING_RE = re.compile(r"^(#{1,2})\s+(.+?)\s*$", re.M)
SKIP_SCHEMES = ("http://", "https://", "mailto:", "#", "ftp://")


def repo_root() -> str:
    return os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def scan_docs(root: str, scans: list[str], exclude_rel: str | None = None) -> list[str]:
    """All *.md under the scanned dirs, as sorted paths relative to root.

    The file this tool is about to write (`exclude_rel`) is never indexed —
    otherwise the index would index itself and never reach a fixed point.
    """
    found: set[str] = set()
    for s in scans:
        base = os.path.join(root, s)
        if os.path.isfile(base):
            found.add(os.path.relpath(base, root))
            continue
        for dirpath, dirnames, filenames in os.walk(base):
            dirnames[:] = sorted(d for d in dirnames if d not in EXCLUDE_DIRS)
            for fn in sorted(filenames):
                if fn.endswith(".md"):
                    rel = os.path.relpath(os.path.join(dirpath, fn), root)
                    if exclude_rel is not None and rel == exclude_rel:
                        continue
                    found.add(rel)
    return sorted(found)


def resolve_link(source_rel: str, raw: str, root: str) -> str | None:
    """Return the repo-relative .md path a link points at, or None."""
    target = urllib.parse.unquote(raw.strip())
    if target.startswith(SKIP_SCHEMES) or not target:
        return None
    target = target.split("#", 1)[0]
    if not target:
        return None
    if not target.endswith(".md"):
        return None  # anchors, assets, non-markdown artifacts
    src_dir = os.path.dirname(os.path.join(root, source_rel))
    resolved = os.path.normpath(os.path.join(src_dir, target))
    root_abs = os.path.normpath(root)
    if not resolved.startswith(root_abs + os.sep) and resolved != root_abs:
        return None  # outside the repo — not ours to index
    if not os.path.exists(resolved):
        return None  # broken link: recorded nowhere (check_site covers those)
    return os.path.relpath(resolved, root).replace(os.sep, "/")


def parse_doc(root: str, rel: str) -> tuple[dict, list[tuple[str, str]]]:
    """One index entry + its outgoing links (duplicates removed by caller)."""
    path = os.path.join(root, rel)
    with open(path, encoding="utf-8", errors="replace") as fh:
        text = fh.read()
    lines = text.count("\n") + (0 if text.endswith("\n") or not text else 1)

    title = os.path.splitext(os.path.basename(rel))[0]
    headings: list[str] = []
    for m in HEADING_RE.finditer(text):
        level, body = m.group(1), m.group(2)
        if level == "#" and not headings:
            title = body
        headings.append(("#" if level == "#" else "##") + " " + body)

    links: set[str] = set()
    for m in LINK_RE.finditer(text):
        tgt = resolve_link(rel, m.group(1), root)
        if tgt is not None:
            links.add(tgt)

    doc = {
        "path": rel.replace(os.sep, "/"),
        "title": title,
        "lines": lines,
        "headings": headings[:200],
    }
    return doc, [(doc["path"], t) for t in sorted(links)]


def build(root: str, scans: list[str],
          exclude_rel: str | None = None) -> tuple[list[dict], list[tuple[str, str]]]:
    docs: list[dict] = []
    link_set: set[tuple[str, str]] = set()
    for rel in scan_docs(root, scans, exclude_rel):
        doc, links = parse_doc(root, rel)
        docs.append(doc)
        link_set.update(links)
    docs.sort(key=lambda d: d["path"])
    # Dedup by (source, target), ordered — typos index.rs discipline.
    links = sorted(link_set)
    return docs, links


def render(root: str, out_md: str, docs: list[dict],
           links: list[tuple[str, str]]) -> str:
    out_dir = os.path.dirname(os.path.join(root, out_md)) or root

    def rel(target: str) -> str:
        r = os.path.relpath(os.path.join(root, target), out_dir)
        return r.replace(os.sep, "/")

    out_deg: dict[str, int] = {}
    in_deg: dict[str, int] = {}
    incoming: dict[str, list[str]] = {}
    for s, t in links:
        out_deg[s] = out_deg.get(s, 0) + 1
        in_deg[t] = in_deg.get(t, 0) + 1
        incoming.setdefault(t, []).append(s)

    def esc(s: str) -> str:
        return s.replace("|", "\\|")

    lines = [
        "# Doc index",
        "",
        "> Generated by `scripts/doc_index.py` — do not edit by hand.",
        "> Index semantics adapted from `typos` (notes-core `index.rs`,",
        "> Apache-2.0): full rebuild, incremental `--file` update, links"
        " deduplicated by (source, target), versioned JSON under `state/`.",
        "",
        f"## Documents ({len(docs)})",
        "",
        "| Document | Title | Lines | Out | In |",
        "|---|---|---:|---:|---:|",
    ]
    for d in docs:
        lines.append(
            f"| [{esc(d['path'])}]({rel(d['path'])}) | {esc(d['title'])} "
            f"| {d['lines']} | {out_deg.get(d['path'], 0)} "
            f"| {in_deg.get(d['path'], 0)} |"
        )

    lines += ["", f"## Backlinks ({len(links)} links)", "",
              "| Document | Linked from |", "|---|---|"]
    never = []
    for d in docs:
        srcs = incoming.get(d["path"])
        if srcs:
            cell = ", ".join(f"[{esc(s)}]({rel(s)})" for s in sorted(srcs))
        else:
            cell = "—"
            never.append(d["path"])
        lines.append(f"| [{esc(d['path'])}]({rel(d['path'])}) | {cell} |")

    # Section TOC for the multi-heading docs (CONSOLIDATED_PLAN et al.).
    rich = [d for d in docs if len(d["headings"]) >= 4]
    if rich:
        lines += ["", "## Section index", ""]
        for d in rich:
            lines.append(f"### {d['title']} (`{d['path']}`)")
            lines.append("")
            for h in d["headings"][:40]:
                lines.append(f"- {h}")
            if len(d["headings"]) > 40:
                lines.append(f"- … ({len(d['headings']) - 40} more)")
            lines.append("")

    if never:
        lines += ["", f"## Never linked ({len(never)})", ""]
        lines += [f"- {p}" for p in never]
        lines.append("")
    return "\n".join(lines) + "\n"


def write_index(root: str, out_json: str, out_md: str,
                docs: list[dict], links: list[tuple[str, str]]) -> None:
    payload = {
        "version": VERSION,
        "generated_at": datetime.datetime.now(datetime.timezone.utc)
        .isoformat(timespec="seconds"),
        "docs": docs,
        "links": [{"source": s, "target": t} for s, t in links],
    }
    jpath = os.path.join(root, out_json)
    os.makedirs(os.path.dirname(jpath) or root, exist_ok=True)
    with open(jpath, "w", encoding="utf-8") as fh:
        json.dump(payload, fh, indent=1, ensure_ascii=False)
        fh.write("\n")
    with open(os.path.join(root, out_md), "w", encoding="utf-8") as fh:
        fh.write(render(root, out_md, docs, links))


def load_index(root: str, out_json: str) -> tuple[list[dict], list[tuple[str, str]]] | None:
    jpath = os.path.join(root, out_json)
    if not os.path.exists(jpath):
        return None
    try:
        with open(jpath, encoding="utf-8") as fh:
            payload = json.load(fh)
        links = [(l["source"], l["target"]) for l in payload["links"]]
        return payload["docs"], links
    except (json.JSONDecodeError, KeyError, TypeError):
        return None


def incremental(root: str, scans: list[str], out_json: str, out_md: str,
                file_rel: str, excl: str) -> int:
    """Re-parse one file and refresh entries touching it (typos
    update_index_for_file). Full rebuild stays authoritative."""
    loaded = load_index(root, out_json)
    if loaded is None:
        docs, links = build(root, scans, excl)
        write_index(root, out_json, out_md, docs, links)
        return 0
    docs, links = loaded
    file_rel = file_rel.replace(os.sep, "/")
    docs = [d for d in docs if d["path"] != file_rel]
    links = [l for l in links if l[0] != file_rel and l[1] != file_rel]
    abs_path = os.path.join(root, file_rel)
    if os.path.exists(abs_path):
        doc, new_links = parse_doc(root, file_rel)
        docs.append(doc)
        links.extend(new_links)
    docs.sort(key=lambda d: d["path"])
    links = sorted(set(links))
    write_index(root, out_json, out_md, docs, links)
    return 0


def query_backlinks(root: str, scans: list[str], out_json: str,
                    target: str) -> int:
    """Incoming/outgoing links for one doc (typos query.rs backlinks())."""
    loaded = load_index(root, out_json)
    docs, links = loaded if loaded is not None else build(root, scans, None)
    rel = os.path.relpath(
        os.path.normpath(os.path.join(root, target)), root).replace(os.sep, "/")
    known = any(d["path"] == rel for d in docs)
    tag = "" if known else "  [warn] not in index — run scripts/doc_index.py first"
    print(f"{rel}{tag}")
    incoming = sorted({s for s, g in links if g == rel})
    outgoing = sorted({g for s, g in links if s == rel})
    print(f"  in  ({len(incoming)}): " + (", ".join(incoming) or "—"))
    print(f"  out ({len(outgoing)}): " + (", ".join(outgoing) or "—"))
    return 0


def query_search(root: str, scans: list[str], out_json: str,
                 text: str) -> int:
    """Case-insensitive search over title, path, headings, then file content
    (typos query.rs search(): metadata first, full text last)."""
    loaded = load_index(root, out_json)
    docs, _links = loaded if loaded is not None else build(root, scans, None)
    q = text.lower()
    hits = 0
    for d in docs:
        where: list[str] = []
        if q in d["title"].lower():
            where.append("title")
        if q in d["path"].lower():
            where.append("path")
        heads = sum(1 for h in d.get("headings", []) if q in h.lower())
        if heads:
            where.append(f"{heads} heading(s)")
        try:
            with open(os.path.join(root, d["path"]), encoding="utf-8",
                      errors="replace") as fh:
                if q in fh.read().lower():
                    where.append("content")
        except OSError:
            pass
        if where:
            hits += 1
            print(f"{d['path']}  [{', '.join(where)}]")
    print(f"[info] {hits} match(es) for {text!r}")
    return 0


def check(root: str, scans: list[str], out_json: str, out_md: str,
          excl: str) -> int:
    docs, links = build(root, scans, excl)
    md_path = os.path.join(root, out_md)
    want_md = render(root, out_md, docs, links)
    try:
        with open(md_path, encoding="utf-8") as fh:
            have_md = fh.read()
    except FileNotFoundError:
        print(f"[stale] {out_md} missing — run scripts/doc_index.py")
        return 1
    loaded = load_index(root, out_json)
    if loaded is None:
        print(f"[stale] {out_json} missing or unreadable")
        return 1
    have_docs, have_links = loaded
    problems = []
    if have_md != want_md:
        problems.append(f"{out_md} does not match a fresh rebuild")
    if have_docs != docs:
        problems.append("stored docs differ from a fresh rebuild")
    if sorted(set(have_links)) != links:
        problems.append("stored links differ from a fresh rebuild")
    if problems:
        for p in problems:
            print(f"[stale] {p}")
        print("run: python3 scripts/doc_index.py")
        return 1
    print(f"[fresh] {out_md} ({len(docs)} docs, {len(links)} links)")
    return 0


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--root", default=repo_root(),
                    help="repository root (default: parent of scripts/)")
    ap.add_argument("--scan", action="append", default=None,
                    metavar="DIR", help="dir to scan (repeatable; default: root)")
    ap.add_argument("--out-md", default="DOC_INDEX.md")
    ap.add_argument("--out-json", default=os.path.join("state", "doc_index.json"))
    ap.add_argument("--file", metavar="PATH",
                    help="incremental update for one file instead of full rebuild")
    ap.add_argument("--check", action="store_true",
                    help="verify the index is fresh; exit 1 if stale")
    ap.add_argument("--backlinks", metavar="PATH",
                    help="print incoming/outgoing links for one doc "
                         "(typos query backlinks)")
    ap.add_argument("--search", metavar="TEXT",
                    help="search titles/paths/headings/content "
                         "(typos query search)")
    args = ap.parse_args(argv)

    root = os.path.abspath(args.root)
    scans = args.scan or ["."]
    excl = os.path.relpath(os.path.join(root, args.out_md), root).replace(os.sep, "/")
    try:
        if args.check:
            return check(root, scans, args.out_json, args.out_md, excl)
        if args.backlinks:
            return query_backlinks(root, scans, args.out_json, args.backlinks)
        if args.search:
            return query_search(root, scans, args.out_json, args.search)
        if args.file:
            return incremental(root, scans, args.out_json, args.out_md, args.file, excl)
        docs, links = build(root, scans, excl)
        write_index(root, args.out_json, args.out_md, docs, links)
        print(f"[ok] indexed {len(docs)} docs, {len(links)} links -> {args.out_md}")
        return 0
    except OSError as exc:
        print(f"[error] {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
