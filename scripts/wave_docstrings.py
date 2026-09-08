#!/usr/bin/env python3
"""Extract each wave node's source docstring into state/wave_docstrings.json
(keyed by slug).  Idempotent; consumed by wave_metadata.py."""
import json

WS = "/home/leo/prove2me_workspace"
PROJ = "/home/leo/Projects/timepiece"


def doc_text(leaf, dstart, dend):
    src = open(f"{PROJ}/BookProof/{leaf}.lean", encoding="utf-8").read()
    lines = src.split("\n")
    return "\n".join(lines[dstart["line"] - 1:dend["line"]])


def main():
    man = json.load(open(f"{WS}/state/wave_manifest.json"))
    out = {}
    for m in man:
        leaf = m["leaf"]
        with open(f"{WS}/state/sketch/sketch_{leaf}.jsonl") as f:
            for line in f:
                r = json.loads(line)
                if r["kind"] == "decl" and r.get("nameText") == m["name"].split(".")[-1]:
                    ds = r.get("docstring")
                    if ds:
                        out[m["slug"]] = doc_text(leaf, ds["start"], ds["end"])
                    break
    with open(f"{WS}/state/wave_docstrings.json", "w", encoding="utf-8") as f:
        json.dump(out, f, indent=1, ensure_ascii=False)
    print(f"docstrings for {len(out)} of {len(man)} nodes")


if __name__ == "__main__":
    main()
