#!/usr/bin/env python3
"""§2.64 census: upstream `include X in` whose next decl drops X from its
statement -> the 58-node dropped-include class.

Method (PIPELINE_PLAN §2.64): walk the upstream chapter sources, track
namespace stacks, and for every `include (...) in` line take the NEXT
top-level declaration; the class member is a decl whose statement (text
between the decl head and `:=` / `by`) mentions none of the included
variables.  Maps each hit to its Thm stub via the wave manifest (authoritative
name -> slug/file) and reports ledger + platform-publish state.

Usage:
  python3 debug/census58.py            # full report
  python3 debug/census58.py --names    # one dotted name per line
"""
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
UPSTREAM = os.environ.get(
    "UPSTREAM", "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/timepiece331/BookProof")

DECL_RE = re.compile(r"^(?:(?:private|protected|noncomputable|internal)\s+)*(?:@[A-Za-z0-9_'.\[\] ]*\s*)*(theorem|lemma|def|abbrev)\s+([A-Za-z0-9_'.]+)")
INC_RE = re.compile(r"^include\s+(.+?)\s+in\b")
NS_RE = re.compile(r"^namespace\s+([A-Za-z0-9_.']+)(?:\s*--.*)?$")
SEC_RE = re.compile(r"^section(?:\s+.*)?$")
END_RE = re.compile(r"^end(?:\s+([A-Za-z0-9_.']+))?\s*$")


def scan():
    hits = []
    for root, _dirs, files in os.walk(UPSTREAM):
        for fn in sorted(files):
            if not fn.endswith(".lean"):
                continue
            path = os.path.join(root, fn)
            try:
                lines = open(path, encoding="utf-8").read().splitlines()
            except (OSError, UnicodeDecodeError):
                continue
            ns_stack = []
            pending_includes = []   # (vars, line-no)
            for i, raw in enumerate(lines):
                line = raw.split("--")[0].rstrip()
                s = line.strip()
                m = NS_RE.match(s)
                if m:
                    ns_stack.append(("ns", m.group(1)))
                    continue
                if SEC_RE.match(s):
                    ns_stack.append(("sec", ""))
                    continue
                m = END_RE.match(s)
                if m and ns_stack:
                    ns_stack.pop()
                    continue
                m = INC_RE.match(s)
                if m:
                    pending_includes.append((m.group(1).split(), i + 1))
                    continue
                # a decl head clears any include that had no decl follow it
                m = DECL_RE.match(s)
                if m:
                    if pending_includes:
                        # statement text: decl head until ':=' at depth 0
                        stmt_parts = []
                        j = i
                        while j < len(lines):
                            stmt_parts.append(lines[j])
                            if ":=" in lines[j] or re.search(r"\bby\b", lines[j]):
                                break
                            j += 1
                        stmt = " ".join(stmt_parts)
                        dropped = []
                        for vars_, inc_ln in pending_includes:
                            missing = [v for v in vars_
                                       if not re.search(r"\b%s\b" % re.escape(v), stmt)]
                            if missing:
                                dropped.append((missing, inc_ln))
                        if dropped:
                            nsv = [x[1] for x in ns_stack if x[0] == "ns"]
                            name = (".".join(nsv + [m.group(2)])
                                    if nsv else m.group(2))
                            hits.append({
                                "name": name,
                                "kind": m.group(1),
                                "file": os.path.relpath(path, UPSTREAM),
                                "line": i + 1,
                                "dropped": dropped,
                            })
                    pending_includes = []
                    continue
                # `include X in` is a command that applies to the NEXT decl;
                # docstrings/variables in between are irrelevant (never clear).
    return hits


def main():
    hits = scan()
    # dedupe: chapters exist both flat and as Part*.lean directories
    seen = {}
    for h in hits:
        if h["name"] not in seen:
            seen[h["name"]] = h
        else:
            seen[h["name"]]["dup"] = seen[h["name"]].get("dup", 1) + 1
    hits = list(seen.values())
    # name -> manifest record (slug/file), from every wave manifest part
    man = {}
    for fn in sorted(os.listdir(os.path.join(WS, "state"))):
        if fn.startswith("wave_manifest") and fn.endswith(".json"):
            try:
                data = json.load(open(os.path.join(WS, "state", fn)))
            except (OSError, ValueError):
                continue
            recs = (data.get("theorems") or data) if isinstance(data, dict) else data
            if isinstance(recs, dict):
                recs = list(recs.values())
            for v in recs or []:
                    if isinstance(v, dict) and v.get("name") and v.get("file"):
                        man[v["name"]] = v
    led = json.load(open(os.path.join(WS, "state", "pipeline.json")))["items"]
    rows = []
    for h in hits:
        rec = man.get(h["name"])
        slug = (rec or {}).get("slug") or h["name"].replace(".", "_")
        stub = f"{WS}/Theorems/Thm_{slug}.lean"
        h["slug"] = slug
        h["in_manifest"] = bool(rec)
        h["stub_exists"] = os.path.exists(stub)
        h["thm_status"] = (led.get("thm:" + slug) or {}).get("status", "ABSENT")
        h["sol_status"] = (led.get("sol:" + slug) or {}).get("status", "ABSENT")
        rows.append(h)
    if "--names" in sys.argv:
        for h in rows:
            print(h["name"])
        return 0
    only_pub = [h for h in rows if h["thm_status"] in ("done", "pending")]
    from collections import Counter
    c = Counter(h["thm_status"] for h in rows)
    print(f"unique include-drop decls: {len(rows)}  "
          f"published(done)={c['done']} pending={c['pending']} absent={c['ABSENT']} "
          f"manifest-mapped={sum(1 for h in rows if h['in_manifest'])} "
          f"sol-done={sum(1 for h in rows if h['sol_status'] == 'done')}")
    if "--published" in sys.argv:
        rows = [h for h in rows if h["thm_status"] == "done"]
        print(f"-- published subset: {len(rows)}")
    for h in rows:
        vars_ = ",".join(",".join(d[0]) for d in h["dropped"])
        print(f"  [{h['thm_status']:7}] [{h['sol_status']:7}] "
              f"{h['name']}  drops={vars_}  ({h['file']}:{h['line']})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
