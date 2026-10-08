#!/usr/bin/env python3
"""For each root-failure unknown identifier, classify the repair:

* STUB-READY   : a thm stub declares it AND is in the ready set -> add
  `import Theorems.<stub>` (+ `open <ns>` if missing); bundle then unblocks
  once the thm publishes (free defer until then).
* STUB-PENDING : stub exists but is not ready -> report why-blocked;
  bundle stays deferred (also fine, but slower).
* NO-STUB      : nothing declares it -> needs an embed from BookProof source
  (or another def bundle provides it under a different import).

Prints a table; writes nothing.
"""
import os
import re
import subprocess
import collections

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
ERR = re.compile(r"Unknown (?:identifier|constant) `([^`]+)`")
THM_NAME = re.compile(r"^theorem\s+([A-Za-z_][\w.'!?]*)", re.M)


def ready(path):
    try:
        return set(open(path).read().split())
    except OSError:
        return set()


def main():
    rdy = ready("/tmp/ready_thms.txt")

    idents = collections.OrderedDict()
    for lf in sorted(os.listdir("/tmp/root_errors")):
        if not (lf.startswith("Def_") and lf.endswith(".log")):
            continue
        bundle = lf[4:-4]
        if bundle.endswith(".recheck"):
            continue
        for ln in open(f"/tmp/root_errors/{lf}", errors="ignore"):
            m = ERR.search(ln)
            if m:
                fq = m.group(1)
                base = fq.rsplit(".", 1)[-1]
                idents.setdefault((bundle, base), fq)

    # stub index: base name -> [(stub, full_name, ns)]
    stubs = collections.defaultdict(list)
    for f in os.listdir(f"{WS}/Theorems"):
        if not (f.startswith("Thm_") and f.endswith(".lean")):
            continue
        txt = open(f"{WS}/Theorems/{f}", encoding="utf-8",
                   errors="ignore").read()
        m = THM_NAME.search(txt)
        if m:
            ns, _, base = m.group(1).rpartition(".")
            stubs[base].append((f[:-5], m.group(1), ns))

    # def decls providing the ident

    for (bundle, base), fq in sorted(idents.items()):
        cands = stubs.get(base, [])
        btxt = open(f"{WS}/Definitions/Def_{bundle}.lean",
                    encoding="utf-8", errors="ignore").read()
        if not cands:
            print(f"NO-STUB  {bundle} :: {base}")
            continue
        for stub, full, ns in cands:
            imports_it = f"import Theorems.{stub}" in btxt
            opens_ns = bool(re.search(rf"^open\s+.*\b{re.escape(ns.split('.')[-1])}\b"
                                      rf"|^open\s+.*\b{re.escape(ns)}\b",
                                      btxt, re.M))
            status = "READY" if stub in rdy else "not-ready"
            print(f"STUB-{status:10s} {bundle} :: {base}  via {stub}"
                  f"  imported={imports_it} opens_ns={opens_ns}")


if __name__ == "__main__":
    main()
