#!/usr/bin/env python3
"""Fix sols whose offline verdict is FAIL with `Unknown identifier/namespace`.

Population: pending sols whose own thm is DONE (so they are otherwise
submittable) and whose imports are all PUBLISHED -- 313 items, of which 183
are missing-import/missing-open cases.  For each failing identifier:

* declared in a PUBLISHED def bundle  -> add `import Definitions.Def_X`
  (+ `open <ns>` when the bare name needs it);
* declared in a PUBLISHED thm stub    -> add `import Theorems.Thm_X`;
* declared only in UNPUBLISHED local text -> BLOCKED (report; the sol waits
  for that def to publish -- an unpublished import would just fail again);
* nowhere                             -> BLOCKED (needs an embed).

Then re-run the offline checker on the touched slugs; verdicts that flip to
`ok` re-enter the ready set on the next `recompute_ready`.

Usage:
  python3 debug/fix_sol_offline_errors.py --dry-run
  python3 debug/fix_sol_offline_errors.py --apply
"""
import argparse
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(HERE)
sys.path.insert(0, HERE)
from restore_opens import scan  # noqa: E402

SOLS = os.path.join(WS, "Solutions")
PUB = os.path.join(WS, "state", "published_bundles")
STATE = os.path.join(WS, "state", "pipeline.json")
OFF = os.path.join(WS, "state", "offline_pending_check.json")
FIXABLE = "/tmp/fixableA.json"

# Trailing backtick optional: stored verdicts truncate at 205 chars, so the
# ident often arrives as a bare prefix (`bornWeight_eq_scoreSoftmax_neg_dist_`).
UNK_ID = re.compile(r"Unknown (?:identifier|constant) `([^`\n]+)`?")
UNK_NS = re.compile(r"unknown namespace `([^`]+)`")
# Bare Mathlib identifiers that need a namespace opened, not an import
# (measured: 17 sols died on `Measure`, 1 on `Tendsto`).
OPEN_MAP = {"Measure": "MeasureTheory", "Tendsto": "Topology",
            "integrable": "MeasureTheory", "aemeasurable": "MeasureTheory",
            "memLp": "MeasureTheory"}


def build_decl_index():
    """base name -> [(bundle, full_ns), ...] over PUBLISHED def text,
    plus the same over local (unpublished) text to tell BLOCKED apart;
    and namespace -> [bundle] over published text (for `unknown namespace`)."""
    pub, loc, nsidx = {}, {}, {}
    for root, idx in ((PUB, pub), (os.path.join(WS, "Definitions"), loc)):
        if not os.path.isdir(root):
            continue
        for fn in sorted(os.listdir(root)):
            if not (fn.startswith("Def_") and fn.endswith(".lean")):
                continue
            try:
                _, decls = scan(open(os.path.join(root, fn),
                                     encoding="utf-8", errors="ignore")
                                .read().split("\n"))
            except Exception:
                continue
            for (ns, base) in decls:
                idx.setdefault(base, []).append((fn[4:-5], ns))
                if idx is pub:
                    nsidx.setdefault(ns, []).append(fn[4:-5])
    # published thm stubs: module -> (full name) via state done-ness
    return pub, loc, nsidx


def has_open(pre, ns):
    """Is `ns` a token of some `open ...` line (word-exact, so
    `open BookProof.ChapterF1` does NOT count as `open BookProof`)?"""
    for line in pre.split("\n"):
        toks = line.strip().split()
        if len(toks) >= 2 and toks[0] == "open" and ns in toks[1:]:
            return True
    return False


def published_stub_for(base, st_items):
    """PUBLISHED thm stubs whose own `theorem <FQ>` has this exact base.
    Returns [(slug, fq, ns)]; empty when ambiguous or none."""
    hits = []
    for k, v in st_items.items():
        if not k.startswith("thm:") or not isinstance(v, dict):
            continue
        if v.get("status") != "done":
            continue
        slug = k[4:]
        if not slug.endswith(base):
            continue
        try:
            txt = open(os.path.join(WS, "Theorems", f"Thm_{slug}.lean"),
                       encoding="utf-8", errors="ignore").read()
        except OSError:
            continue
        m = re.search(r"^theorem\s+([A-Za-z_][\w.'!?]*)", txt, re.M)
        if not m:
            continue
        fq = m.group(1)
        if fq.rsplit(".", 1)[-1] == base:
            ns, _, _ = fq.rpartition(".")
            hits.append((slug, fq, ns))
    return hits


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true")
    ap.add_argument("--fixable", default=FIXABLE)
    a = ap.parse_args()

    st = json.load(open(STATE))["items"]
    off = json.load(open(OFF))["sol"]["items"]
    pub_decls, loc_decls, nsidx = build_decl_index()
    man = set(json.load(open(os.path.join(
        WS, "state", "published_bundles", "manifest.json"))))

    slugs = json.load(open(a.fixable))
    blocked, planned = [], {}
    for slug in slugs:
        v = off.get(slug)
        if not isinstance(v, str) or not v.startswith("FAIL"):
            continue
        path = os.path.join(SOLS, f"Sol_{slug}.lean")
        try:
            txt = open(path, encoding="utf-8").read()
        except OSError:
            continue
        pre = txt.split("theorem solution")[0]
        idents = UNK_ID.findall(v)
        nss = UNK_NS.findall(v)
        add_imp, add_open = [], []
        block = []
        for ns in nss:
            cands = sorted(set(nsidx.get(ns, ())))
            if not cands:
                block.append(f"ns {ns} (declared nowhere published)")
            elif len(cands) == 1:
                if f"import Definitions.Def_{cands[0]}" not in txt:
                    add_imp.append(f"Definitions.Def_{cands[0]}")
            else:
                block.append(f"ns {ns} (ambiguous: {cands})")
        def want_open(ns):
            """queue an open unless the preamble already has it (word-exact)
            or an earlier ident already queued it"""
            if ns and ns not in add_open and not has_open(pre, ns):
                add_open.append(ns)

        def pick(idx, base):
            """exact match, else unique-prefix match (truncated verdict);
            returns the candidate list, or 'AMBIG:<keys>'"""
            if base in idx:
                return idx[base]
            p = [k for k in idx if k.startswith(base)]
            if len(p) == 1:
                return idx[p[0]]
            if len(p) > 1:
                return "AMBIG:" + ",".join(sorted(p)[:5])
            return []

        for ident in idents:
            fq = ident.rstrip("`")  # truncated verdicts have no closing tick
            parts = fq.split(".")
            base = parts[-1]
            ns_hint = ".".join(parts[:-1]) if len(parts) > 1 else ""
            if not base:
                continue
            if base in OPEN_MAP:
                want_open(OPEN_MAP[base])
                continue

            def parent_of(ns):
                # FQ ref `Comp.rest`: the PARENT of the decl namespace must be
                # open so the first component resolves (verified empirically:
                # `open BookProof.ChapterF1` does NOT resolve `ChapterF1.numberOp`,
                # `open BookProof` does).
                if ns_hint and ns.endswith("." + ns_hint):
                    return ns[: -(len(ns_hint) + 1)]
                if not ns_hint:
                    return ns
                return ""

            cand = pick(pub_decls, base)
            if isinstance(cand, str):
                block.append(f"{fq} ({cand})")
                continue
            if cand:
                if ns_hint:
                    nar = [(b, ns) for b, ns in cand
                           if ns == ns_hint or ns.endswith("." + ns_hint)]
                    if nar:
                        cand = nar
                bundles = sorted({b for b, _ in cand})
                in_man = [b for b in bundles if b in man]
                if in_man:
                    bundles = in_man
                if len(bundles) > 1:
                    have = [b for b in bundles
                            if f"import Definitions.Def_{b}" in txt]
                    if len(have) == 1:
                        bundles = have
                    else:
                        block.append(f"{fq} (ambiguous bundles: {bundles})")
                        continue
                bundle = bundles[0]
                ns = next(ns for b, ns in cand if b == bundle)
                if bundle not in man:
                    block.append(f"{base} (bundle {bundle} not published)")
                    continue
                imp = f"Definitions.Def_{bundle}"
                if f"import {imp}" not in txt:
                    add_imp.append(imp)
                want_open(parent_of(ns))
                continue

            stubs = published_stub_for(base, st)
            if len(stubs) > 1 and ns_hint:
                nar = [(s, f, n) for s, f, n in stubs
                       if n == ns_hint or n.endswith("." + ns_hint)]
                if len(nar) == 1:
                    stubs = nar
            if len(stubs) == 1:
                slug_s, _, ns = stubs[0]
                add_imp.append(f"Theorems.Thm_{slug_s}")
                want_open(parent_of(ns))
                continue
            if len(stubs) > 1:
                block.append(f"{base} (ambiguous stubs: "
                             f"{[s[0] for s in stubs]})")
                continue
            loc_c = pick(loc_decls, base)
            if isinstance(loc_c, str):
                block.append(f"{fq} ({loc_c})")
            elif loc_c:
                block.append(f"{base} (only in unpublished "
                             f"Def_{loc_c[0][0]})")
            else:
                block.append(f"{fq} (declared nowhere)")
        if block:
            blocked.append((slug, block))
            continue
        if add_imp or add_open:
            planned[slug] = {"imports": sorted(set(add_imp)),
                             "opens": sorted(set(add_open))}

    print(f"fixable: {len(slugs)} | planned: {len(planned)} | "
          f"blocked: {len(blocked)}")
    for slug, det in list(planned.items())[:12]:
        print(f"  ADD {slug}: +{det['imports']} +{det['opens']}")
    bl = {}
    for slug, det in blocked:
        for d in det:
            bl[d.split(" (")[0]] = bl.get(d.split(" (")[0], 0) + 1
    print("\nblocked ident histogram (top):")
    for k2, n in sorted(bl.items(), key=lambda p: -p[1])[:20]:
        print(f"  {n:4d}  {k2}")
    if not a.apply or not planned:
        return 0

    for slug, det in planned.items():
        path = os.path.join(SOLS, f"Sol_{slug}.lean")
        lines = open(path, encoding="utf-8").read().split("\n")
        imp_idx = [i for i, l in enumerate(lines) if l.startswith("import ")]
        at = (max(imp_idx) + 1) if imp_idx else 0
        lines[at:at] = [f"import {m}" for m in det["imports"]]
        # opens go after the import block
        imp_idx = [i for i, l in enumerate(lines) if l.startswith("import ")]
        at = max(imp_idx) + 1
        lines[at:at] = [f"open {n}" for n in det["opens"]]
        open(path, "w", encoding="utf-8").write("\n".join(lines))
        print(f"edited Sol_{slug}.lean")
    with open("/tmp/sols_fix_touched.txt", "w") as fh:
        fh.write("\n".join(sorted(planned)))
    print(f"{len(planned)} file(s) edited -> /tmp/sols_fix_touched.txt")
    return 0


if __name__ == "__main__":
    sys.exit(main())
