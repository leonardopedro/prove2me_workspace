#!/usr/bin/env python3
"""Platform ground truth for what each published Definition module actually declares.

WHY
---
`repair_hollow_defs.py` resolves a regenerated bundle's free identifiers against
the *local* `Definitions/Def_*.lean` files.  That is wrong in two ways:

* the local file can be an empty placeholder while the platform module is live
  (`Definitions/Def_ChapterCarlemanTwoStep.lean` is 182 bytes of `import Mathlib`;
  the published module is a generated stub that declares nothing), and
* bundles the platform published as *stubs* ("Generated def bundle for X" +
  `noncomputable section`) declare **no namespace at all**, so an
  `open BookProof.X` pointing at one is still `unknown namespace` server-side.

The publish-job records carry the exact source text that was published, so the
platform can be asked directly.  `GET /publish-jobs?kind=definition` returns every
job; the newest job per `theorem_name` wins (a FAILED job does not revoke an older
PUBLISHED one -- PIPELINE_PLAN 1e).

OUTPUT
------
`state/defs_index.json`:

    {"job_counts": {...},
     "bundles": {"ChapterX": {"status": "PUBLISHED", "stub": false, "lines": 214,
                              "namespaces": [...], "names": [...]}} ,
     "namespace_owner": {"BookProof.FullQuadratic": "ChapterFullQuadraticEsa", ...},
     "name_owner": {"fqOp": "ChapterFullQuadraticEsa", ...},
     "stub_bundles": [...]}

USAGE
-----
    PROVE2ME_WS=/home/daytona/codebase python3 debug/platform_def_index.py
"""
import collections
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = (os.environ.get("PROVE2ME_WS") or os.path.dirname(HERE)
      or "/home/leo/prove2me_workspace")
sys.path.insert(0, f"{WS}/pipeline")

import upload_pipeline as up  # noqa: E402

OUT = f"{WS}/state/defs_index.json"

NS = re.compile(r"(?m)^namespace\s+(\S+)")
DECL = re.compile(r"(?m)^\s*(?:noncomputable\s+|private\s+|protected\s+|@\[[^\]]*\]\s*)*"
                  r"(?:def|abbrev|theorem|lemma|structure|inductive|class|instance|notation)\s+"
                  r"([A-Za-z_][A-Za-z0-9_'.]*)")
GENERATED_STUB = re.compile(r"Generated def bundle for \w+")


def scan(text):
    """Namespaces + top-level declaration names in a bundle's published source.

    Nested `namespace` blocks are COMPOSED: `namespace BookProof.NavierStokesFlow`
    followed by `namespace FockContinuum` declares
    `BookProof.NavierStokesFlow.FockContinuum`, which is the name a consumer's
    `open` needs.  Recording only the raw tokens published `FockContinuum` as a
    namespace of its own and left the composite looking undeclared, so
    `debug/def_layer_order.py` reported a **false** blocker (`open
    BookProof.NavierStokesFlow.FockContinuum <- ChapterNavierStokesFockContinuum`,
    whose bundle is live) and the def chain was read as unorderable when it was
    not.  `section` pushes too, only so that its `end` pops the right frame;
    sections create no namespace prefix.
    """
    nss, stack = [], []
    for line in text.split("\n"):
        s = line.strip()
        if s == "namespace" or s.startswith("namespace "):
            rel = s.split(None, 1)[1].strip().rstrip(",") if " " in s else ""
            if rel and stack and not rel.startswith("BookProof"):
                enclosing = [x for x in stack if x][-1]
                rel = enclosing + "." + rel
            stack.append(rel)
            if rel:
                nss.append(rel)
        elif s == "section" or s.startswith("section "):
            stack.append("")
        elif s == "end" or s.startswith("end "):
            if stack:
                stack.pop()
    names = [m.split(".")[0] for m in DECL.findall(text)]
    return nss, names


def main():
    jobs = up._paged("publish-jobs", {"kind": "definition"})
    if not jobs:
        print("no definition publish jobs returned")
        return 1
    newest = {}
    for j in jobs:
        name = j.get("theorem_name") or ""
        if not name:
            continue
        prev = newest.get(name)
        stamp = (j.get("updated_at") or j.get("created_at") or "")
        if prev is None or (prev.get("updated_at") or prev.get("created_at") or "") <= stamp:
            newest[name] = j

    bundles = {}
    ns_owner, name_owner = {}, {}
    stubs = []
    for name, j in sorted(newest.items()):
        text = j.get("definitions") or ""
        if not isinstance(text, str):
            text = json.dumps(text)
        nss, names = scan(text)
        stub = bool(GENERATED_STUB.search(text)) and not nss
        bundles[name] = {
            "status": j.get("status"),
            "stub": stub,
            "lines": text.count("\n") + 1 if text else 0,
            "namespaces": nss,
            "names": names,
        }
        if j.get("status") == "PUBLISHED":
            if stub:
                stubs.append(name)
            for ns in nss:
                ns_owner.setdefault(ns, name)
            for n in names:
                name_owner.setdefault(n, name)

    counts = collections.Counter(b["status"] for b in bundles.values())
    doc = {
        "job_counts": dict(counts),
        "job_total": len(jobs),
        "bundles": bundles,
        "namespace_owner": ns_owner,
        "name_owner": name_owner,
        "stub_bundles": sorted(stubs),
    }
    with open(OUT, "w", encoding="utf-8") as f:
        json.dump(doc, f, indent=1, sort_keys=True)

    print(f"{len(jobs)} definition job(s), {len(bundles)} distinct bundle name(s): "
          f"{dict(counts)}")
    print(f"PUBLISHED bundles that declare no namespace (stubs): {len(stubs)}")
    live = [n for n, b in bundles.items() if b["status"] == "PUBLISHED" and not b["stub"]]
    print(f"PUBLISHED bundles with real content: {len(live)}")
    print(f"{len(ns_owner)} namespace(s), {len(name_owner)} declaration name(s) indexed")
    print(f"wrote {OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
