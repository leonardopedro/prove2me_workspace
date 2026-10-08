#!/usr/bin/env python3
"""Where is each root-failure unknown identifier declared?

For every `Unknown identifier/constant X` in /tmp/root_errors/Def_*.log,
find: (a) thm stubs declaring X, (b) def bundles declaring X (WS), (c) the
BookProof source line.  Prints a decision table for the repair pass.
"""
import glob
import os
import re
import subprocess
import collections

WS = os.environ.get("PROVE2ME_WS") or os.getcwd()
ERR = re.compile(r"Unknown (?:identifier|constant) `([^`]+)`")
ERR2 = re.compile(r"Invalid field `([^`]+)`")


def shortname(fq):
    return fq.rsplit(".", 1)[-1]


def main():
    idents = collections.OrderedDict()   # base -> [(bundle, fq, line)]
    for lf in sorted(glob.glob("/tmp/root_errors/Def_*.log")):
        bundle = os.path.basename(lf)[4:-4]
        for ln in open(lf, errors="ignore"):
            m = ERR.search(ln) or ERR2.search(ln)
            if m:
                fq = m.group(1)
                loc = ln.split(": error")[0].split(":", 1)[1][:40]
                idents.setdefault(shortname(fq), []).append((bundle, fq, loc))
    print(f"{len(idents)} distinct idents\n")
    for base, uses in idents.items():
        print(f"## {base}  (used by {sorted({u[0] for u in uses})})")
        # stubs
        out = subprocess.run(
            ["grep", "-rl", "--include=Thm_*.lean", "-m1",
             rf"^theorem .*{re.escape(base)}\b", f"{WS}/Theorems"],
            capture_output=True, text=True).stdout.split()
        for p in out[:6]:
            print(f"   STUB  {os.path.basename(p)[:-5]}")
        # def decls (bare, inside namespaces)
        out = subprocess.run(
            ["grep", "-rn", "--include=Def_*.lean",
             rf"^\s*(?:@\[[^\]]*\]\s*)?(?:theorem|lemma|def|abbrev|structure)\s"
             rf"+{re.escape(base)}\b", f"{WS}/Definitions"],
            capture_output=True, text=True).stdout.splitlines()
        for l in out[:6]:
            print(f"   DEF   {l.split(':')[0][len(WS)+1:]}  {l.split(':',2)[2].strip()[:80]}")
        # source
        out = subprocess.run(
            ["grep", "-rn", "--include=*.lean",
             rf"^\s*(?:theorem|lemma|def)\s+.*\b{re.escape(base)}\s",
             f"{WS}/BookProof"],
            capture_output=True, text=True).stdout.splitlines()
        for l in out[:4]:
            print(f"   SRC   {l.split(':')[0][len(WS)+1:]}:{l.split(':')[1]}")
        print()


if __name__ == "__main__":
    main()
