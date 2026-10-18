#!/usr/bin/env python3
"""Dropped-`include` healer (PIPELINE_PLAN §2.64 class), two modes.

Every class member is an upstream decl bound with `include X in` whose Thm
stub lost the include line, so the stored/elaborated statement is missing a
hypothesis binder.  The repair is always the same shape:

  stub:  insert `include X ...` directly above the `theorem <dotted>` line
         (it lands at the end of the submission preamble, exactly the hoist
         upload_full_project.md prescribes);
  sol:   insert `include X ...` above the `set_option`/`theorem solution`
         chain, so `solution`'s type carries the binder even when the proof
         never mentions the variable.

Modes:
  --fix      in-place repair of THEOREMS/SOLUTIONS for census members whose
             ledger thm is pending/absent-but-in-wave (never published, so no
             platform mutation is needed).  Originals kept as `.bak_inc`.
  --replace  published (ledger thm `done`) members: build `<slug>_inc` stub +
             sol under the new dotted name, add the wave_upload.json entry,
             seed pending thm:/sol: ledger items.  The old node is retired by
             debug/retire_old_nodes.py AFTER the new node proves.

Usage:
  python3 debug/heal_include_class.py --fix [--only SUBSTR]
  python3 debug/heal_include_class.py --replace [--only SUBSTR]
  python3 debug/heal_include_class.py --list
"""
import argparse
import json
import os
import re
import shutil
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, HERE)
import census58  # noqa: E402


def class_rows():
    hits = census58.scan()
    seen, rows = set(), []
    for h in hits:
        if h["name"] in seen:
            continue
        seen.add(h["name"])
        h["slug"] = h["name"].replace(".", "_")
        rows.append(h)
    led = json.load(open(os.path.join(WS, "state", "pipeline.json")))["items"]
    wave = json.load(open(os.path.join(WS, "pipeline", "wave_upload.json")))
    for h in rows:
        h["thm_status"] = (led.get("thm:" + h["slug"]) or {}).get("status", "ABSENT")
        h["sol_status"] = (led.get("sol:" + h["slug"]) or {}).get("status", "ABSENT")
        h["in_wave"] = h["slug"] in wave["thms"]
        h["stub"] = os.path.join(WS, "Theorems", "Thm_%s.lean" % h["slug"])
        h["sol"] = os.path.join(WS, "Solutions", "Sol_%s.lean" % h["slug"])
        h["stub_exists"] = os.path.exists(h["stub"])
        h["sol_exists"] = os.path.exists(h["sol"])
    return rows, wave


def strip_includes(lines):
    """Drop every standalone `include … in` line (some generated sols carry a
    stray trailing one, which must not count as a completed heal)."""
    return [l for l in lines if not re.match(r"^\s*include\s+.+\s+in\s*$", l)]


CTX_RE = re.compile(r"^variable\s+(\{[A-Z]|\[)")


def drop_stale_context(lines, vars_):
    """Chapter stubs stack the variable blocks of SEVERAL upstream decls, so
    a target variable can be declared twice with different types (e.g. two
    `hcomm`s).  `include` then binds the wrong/extra one and the statement's
    type gains a foreign context.  The current decl's block is the LAST one;
    delete the earlier context's variable lines (identified by the last
    context start — `variable {H : Type*} …` / `variable [inst …]` — before
    the last declaration of any target variable)."""
    for v in vars_:
        decls = [i for i, l in enumerate(lines)
                 if l.startswith("variable ") and re.search(
                     r"\b%s\b" % re.escape(v), l)]
        if len(decls) < 2:
            continue
        last = decls[-1]
        starts = [i for i, l in enumerate(lines[:last + 1]) if CTX_RE.match(l)]
        if len(starts) < 2:
            continue
        cut = starts[-1]
        lines = [l for i, l in enumerate(lines)
                 if not (i < cut and l.startswith("variable "))]
        break
    # Bare redeclaration: a later context start re-declares the same type
    # variable with FEWER instance binders (e.g. `{X : Type*} [TopologicalSpace X]`
    # after `{X} [TS] [CS] [T2] [MS] [BS]`); it shadows the full one and the
    # statement then lacks instances.  Delete the bare line; the following
    # `variable (psi …)` lines re-attach to the full context.
    ctx = [i for i, l in enumerate(lines) if CTX_RE.match(l)]
    for j in reversed(ctx):
        m = re.match(r"^variable\s+\{([A-Z][A-Za-z0-9_]*)", lines[j])
        if not m:
            continue
        var, ninst = m.group(1), lines[j].count("[")
        for k in ctx[:ctx.index(j)]:
            mk = re.match(r"^variable\s+\{([A-Z][A-Za-z0-9_]*)", lines[k])
            if mk and mk.group(1) == var and lines[k].count("[") > ninst:
                lines = [l for i, l in enumerate(lines) if i != j]
                break
    return lines


def insert_include(lines, anchor_re, vars_):
    """Insert `include <vars>` above the first line matching anchor_re."""
    inc = "include %s in" % " ".join(vars_)
    if inc in lines:
        return lines, False
    for i, ln in enumerate(lines):
        if re.match(anchor_re, ln):
            # directly above the anchor (before set_option chains etc.)
            return lines[:i] + [inc] + lines[i:], True
    raise SystemExit("anchor not found: %s" % anchor_re)


def dedupe_variables(lines, anchor_re):
    """Drop exact-duplicate preamble lines (generator artifact: some sols
    carry two identical variable blocks, often wrapped; with `include` the
    copies bind DIFFERENT universe-polymorphic constants, and an ORPHANED
    continuation line (`  [MeasurableSpace X] …`) elaborates as standalone
    always-included instance binders)."""
    out, seen, in_pre = [], set(), True
    for ln in lines:
        if in_pre and re.match(anchor_re, ln):
            in_pre = False
        if in_pre and ln.strip():
            if (ln.startswith("variable ") or ln.startswith("open ")
                    or ln[:1].isspace()):
                if ln in seen:
                    continue
                seen.add(ln)
        out.append(ln)
    return out


def heal_stub(path, vars_, new_dotted=None, old_dotted=None):
    txt = open(path, encoding="utf-8").read()
    lines = txt.splitlines()
    if new_dotted:
        # identifier-safe rename: never touch a longer name with old as prefix
        pat = re.compile(re.escape(old_dotted) + r"(?![A-Za-z0-9_'.!?])")
        lines = [pat.sub(new_dotted, l) for l in lines]
        anchor = r"^theorem\s+%s(?![A-Za-z0-9_'.!?])" % re.escape(new_dotted)
    else:
        anchor = r"^theorem\s+%s(?![A-Za-z0-9_'.!?])" % re.escape(old_dotted)
    lines = dedupe_variables(lines, anchor)
    lines = strip_includes(lines)
    lines = drop_stale_context(lines, vars_)
    lines, changed = insert_include(lines, anchor, vars_)
    return "\n".join(lines) + ("\n" if txt.endswith("\n") else ""), changed


def heal_sol(path, vars_, new_dotted=None, old_dotted=None):
    txt = open(path, encoding="utf-8").read()
    lines = txt.splitlines()
    if new_dotted:
        # rename the `solution of <old>` header (the pipeline's
        # target_already_published parses it and would block the item as a
        # duplicate of the old node)
        pat = re.compile(re.escape(old_dotted) + r"(?![A-Za-z0-9_'.!?])")
        lines = [pat.sub(new_dotted, l) for l in lines]
    lines = dedupe_variables(lines, r"^theorem\s+solution\b")
    lines = strip_includes(lines)
    lines = drop_stale_context(lines, vars_)
    lines, changed = insert_include(lines, r"^theorem\s+solution\b", vars_)
    return "\n".join(lines) + ("\n" if txt.endswith("\n") else ""), changed


def wave_entry_for(old, new_name, new_slug, drops):
    e = json.loads(json.dumps(old))
    e["name"] = new_name
    e["file"] = "Theorems/Thm_%s.lean" % new_slug
    e["sol"] = "Solutions/Sol_%s.lean" % new_slug
    e["title"] = e["title"].replace(old["name"], new_name)
    e["nl"] = e["nl"].replace(old["name"], new_name)
    e["nl"] += ("\n\nReplaces the retired node `%s`, whose stored statement "
                "omitted the `%s` hypothesis binder (dropped `include`)."
                % (old["name"], "`, `".join(drops)))
    return e


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--fix", action="store_true")
    ap.add_argument("--replace", action="store_true")
    ap.add_argument("--list", action="store_true")
    ap.add_argument("--only", default=None)
    args = ap.parse_args()

    rows, wave = class_rows()
    if args.only:
        rows = [h for h in rows if args.only in h["name"] or args.only in h["slug"]]

    if args.list or not (args.fix or args.replace):
        from collections import Counter
        c = Counter(h["thm_status"] for h in rows)
        print("class: %d  published=%d pending=%d absent=%d  "
              "in_wave=%d stub=%d sol=%d"
              % (len(rows), c["done"], c["pending"], c["ABSENT"],
                 sum(1 for h in rows if h["in_wave"]),
                 sum(1 for h in rows if h["stub_exists"]),
                 sum(1 for h in rows if h["sol_exists"])))
        for h in rows:
            print("  [%s/%s] %s drops=%s%s%s"
                  % (h["thm_status"], h["sol_status"], h["slug"],
                     ",".join(",".join(d[0]) for d in h["dropped"]),
                     "" if h["stub_exists"] else " NO-STUB",
                     "" if h["in_wave"] else " NO-WAVE"))
        return 0

    mode = "replace" if args.replace else "fix"
    report = {"fixed": [], "replaced": [], "skipped": []}
    for h in rows:
        drops = sorted({v for d in h["dropped"] for v in d[0]})
        h["_drops"] = drops
        if h["thm_status"] == "done":
            tier = "replace"
        else:
            tier = "fix"
        if tier != mode:
            report["skipped"].append((h["slug"], "tier!=mode"))
            continue
        if not h["stub_exists"]:
            report["skipped"].append((h["slug"], "no stub"))
            continue

        if tier == "replace":
            new_slug = h["slug"] + "_inc"
            new_dotted = h["name"] + "_inc"
            src_stub, dst_stub = h["stub"], os.path.join(WS, "Theorems", "Thm_%s.lean" % new_slug)
            src_sol, dst_sol = h["sol"], os.path.join(WS, "Solutions", "Sol_%s.lean" % new_slug)
            txt, _ = heal_stub(src_stub, drops, new_dotted, h["name"])
            open(dst_stub, "w", encoding="utf-8").write(txt)
            if h["sol_exists"]:
                txt, _ = heal_sol(src_sol, drops, new_dotted, h["name"])
                open(dst_sol, "w", encoding="utf-8").write(txt)
            else:
                report["skipped"].append((h["slug"], "no sol file"))
            if h["in_wave"]:
                entry = wave_entry_for(wave["thms"][h["slug"]], new_dotted, new_slug, drops)
                wave["thms"][new_slug] = entry
                # the pipeline's ORDER iterates sol_order, so the new item
                # must also join that list to ever be submitted
                so = wave.setdefault("sol_order", [])
                if new_slug not in so:
                    so.append(new_slug)
                rec = {"status": "pending", "attempts": 0}
                led_path = os.path.join(WS, "state", "pipeline.json")
                led = json.load(open(led_path))
                led["items"].setdefault("thm:" + new_slug, dict(rec))
                led["items"].setdefault("sol:" + new_slug, dict(rec))
                json.dump(led, open(led_path, "w"), separators=(",", ":"))
            else:
                report["skipped"].append((h["slug"], "no wave entry"))
            report["replaced"].append(new_slug)
        else:
            # heal from the PRISTINE backup when one exists (re-runs must not
            # heal an already-healed file or clobber the good backup)
            src_stub = h["stub"] + ".bak_inc" if os.path.exists(
                h["stub"] + ".bak_inc") else h["stub"]
            src_sol = h["sol"] + ".bak_inc" if os.path.exists(
                h["sol"] + ".bak_inc") else h["sol"]
            if src_stub != h["stub"] + ".bak_inc":
                shutil.copy(src_stub, h["stub"] + ".bak_inc")
            txt, ch = heal_stub(src_stub, drops, None, h["name"])
            if ch:
                open(h["stub"], "w", encoding="utf-8").write(txt)
            if h["sol_exists"]:
                if src_sol != h["sol"] + ".bak_inc":
                    shutil.copy(src_sol, h["sol"] + ".bak_inc")
                txt, ch = heal_sol(src_sol, drops)
                if ch:
                    open(h["sol"], "w", encoding="utf-8").write(txt)
            report["fixed"].append(h["slug"])

    if args.replace:
        wp = os.path.join(WS, "pipeline", "wave_upload.json")
        shutil.copy(wp, wp + ".bak_include")
        json.dump(wave, open(wp, "w"), ensure_ascii=False, separators=(",", ":"))
    print(json.dumps({k: len(v) for k, v in report.items()}))
    for k in ("skipped",):
        for s in report[k]:
            print("  skip", s)
    for s in report["replaced"]:
        print("  new ", s)
    return 0


if __name__ == "__main__":
    sys.exit(main())
