#!/usr/bin/env python3
"""Audit sketch spans for the ways they can silently corrupt a generated stub.

The per-chapter `WARNING n/m sketch spans look misaligned` in `wave_generate.py`
is ADVISORY and, per its own comment, fires on any span whose recorded LINE
disagrees with the source -- which is routine when a declaration's `declStart`
sits on its docstring. That makes it useless as a signal: `ChapterQgOuterFockFlow`
warns about 7 spans and every one of them is fine.

These checks are the ones that actually matter, because each one produces a
*silently wrong* stub rather than an error:

1. `:=` inside a comment -- `find_term_as` scans raw text for `:=` with no
   comment awareness, so a docstring mentioning `x := y` makes it stop early and
   the emitted statement is truncated. This is the `cannot split
   formal_statement` / `Invalid field` failure class.
2. span start is a bare fragment (`)`, `,`, `]`), i.e. `declStart` landed inside
   a previous declaration -- a stray character survives into the statement.
3. offset out of range for the file.
4. span start is a wrapper the preamble filters drop (`open ... in`, `omit ...
   in`, `set_option ... in`), so the wrapper never reaches the stub.

    python3 debug/audit_sketch.py [chapter ...] [--json out.json]
"""
import argparse
import json
import os
import re
import sys

WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "scripts"))

OPENER = re.compile(
    r"^\s*(@\[[^\]]*\]\s*)?(private\s+|protected\s+|noncomputable\s+|nonrec\s+)*"
    r"(def|theorem|lemma|abbrev|instance|structure|example|opaque)\b")
WRAPPER = re.compile(
    r"^\s*(open|omit|set_option|include|variable|sections?\b|namespace|universe"
    r"|noncomputable section|attribute|local notation|notation)\b")
SCOPED = re.compile(r"^\s*open\s+(scoped\s+)?(.+?)\s+in\s*$")


def comment_depth(seg):
    """Unclosed `/- -/` depth at the end of `seg`; 0 means we are in code."""
    d = i = 0
    while i < len(seg) - 1:
        if seg.startswith("/-", i):
            d += 1
            i += 2
        elif seg.startswith("-/", i):
            d -= 1
            i += 2
            if d <= 0:
                return 0
        else:
            i += 1
    return d


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("chapters", nargs="*")
    ap.add_argument("--json")
    args = ap.parse_args()

    os.environ.setdefault("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
    import importlib.util
    spec = importlib.util.spec_from_file_location(
        "wg", os.path.join(WS, "scripts", "wave_generate.py"))
    wg = importlib.util.module_from_spec(spec)
    sys.argv = ["wg"]
    spec.loader.exec_module(wg)

    wave_path = os.path.join(WS, "pipeline", "wave_upload.json")
    if args.chapters:
        chapters = args.chapters
    elif os.path.exists(wave_path):
        wave = json.load(open(wave_path, encoding="utf-8"))
        chapters = sorted({v.get("chapter") for v in wave["thms"].values() if v.get("chapter")})
    else:
        chapters = sorted(c for c in os.listdir(os.path.join(WS, "Definitions"))
                          if c.startswith("Def_Chapter") and c.endswith(".lean"))

    graph = wg.load_graph()
    findings = []
    tot = 0
    for leaf in chapters:
        try:
            bt = wg.src_byte_text(leaf)
            decls = wg.load_decls(leaf, graph)
        except Exception as e:                      # noqa: BLE001 - report and go on
            findings.append({"chapter": leaf, "kind": "load_error", "detail": str(e)[:80]})
            continue
        if not decls:
            continue
        doc = wg.module_doc(bt)
        defmat, embedded, nodes, inline = wg.classify(decls, doc, bt)
        owned = {getattr(d, "uname", None) for d in (defmat | embedded)}
        nbytes = len(bt.text.encode("utf-8"))
        for nd in nodes:
            if nd.uname in owned:
                continue
            tot += 1
            nm = nd.uname
            if nd.s < 0 or nd.s >= nbytes:
                findings.append({"chapter": leaf, "kind": "offset_out_of_range",
                                 "node": nm, "detail": f"s={nd.s} len={nbytes}"})
                continue
            head = bt.text[nd.s:nd.s + 400]
            first = next((l.strip() for l in head.split("\n") if l.strip()), "")
            if first[:1] in (")", ",", "]", "}", "|"):
                findings.append({"chapter": leaf, "kind": "fragment_start",
                                 "node": nm, "detail": first[:50]})
            elif SCOPED.match(first):
                findings.append({"chapter": leaf, "kind": "scoped_open_at_start",
                                 "node": nm, "detail": first[:50]})
            elif WRAPPER.match(first) and not OPENER.match(first):
                findings.append({"chapter": leaf, "kind": "wrapper_at_start",
                                 "node": nm, "detail": first[:50]})
            t = wg.find_term_as(bt.text, nd.s)
            if t is None:
                findings.append({"chapter": leaf, "kind": "no_term_as",
                                 "node": nm, "detail": ""})
            elif comment_depth(bt.text[nd.s:t]) > 0:
                findings.append({"chapter": leaf, "kind": "term_as_in_comment",
                                 "node": nm,
                                 "detail": bt.text[nd.s:t][-60:].replace("\n", "|")})

    by_kind = {}
    for f in findings:
        by_kind.setdefault(f["kind"], []).append(f)
    print(f"audited {tot} nodes across {len(chapters)} chapters")
    if not findings:
        print("no findings")
    for kind, fs in sorted(by_kind.items(), key=lambda x: -len(x[1])):
        print(f"  {kind:24} {len(fs):5}")
        seen = set()
        for f in fs:
            if f["chapter"] in seen:
                continue
            seen.add(f["chapter"])
            if len(seen) > 4:
                break
            print(f"      {f['chapter'][:34]:36} {str(f.get('node',''))[-30:]:32} {f['detail'][:40]}")
    if args.json:
        json.dump(findings, open(args.json, "w"), indent=1)
        print(f"wrote {args.json}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())