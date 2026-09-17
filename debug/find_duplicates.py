#!/usr/bin/env python3
"""Find reusable / duplicated theorems on prove2me before adding more.

Two questions, one index:

  1. **Cross-user duplication** — does the platform already hold a theorem with a
     statement (or a name) that a *new* timepiece theorem would re-state?  If so,
     import it (a reduction) instead of submitting a twin.
  2. **Pipeline duplication** — for the theorems already in the wave, which of them
     collide with an existing platform node (ours or another user's)?

The platform catalogue in the default environment (Lean 4.33.1) is ~84k theorems,
so the fetch is **resumable**: `--index` appends pages to `state/platform_index.jsonl`
and records `next_offset`, and repeated bounded calls finish it.

Usage
-----
    python3 debug/find_duplicates.py --index --pages 120      # bounded chunk
    python3 debug/find_duplicates.py --index                 # until budget/end
    python3 debug/find_duplicates.py --report                # classify
    python3 debug/find_duplicates.py --report --max 40       # cap examples

Matching is exact on a normalized statement hash and on a normalized
declaration-only hash, plus a token-set signature; the classes and their limits
are printed in the report header.  Read-only against the platform.
"""
import argparse
import hashlib
import json
import os
import re
import sys
import time

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402

INDEX = os.path.join(WS, "state", "platform_index.jsonl")
META = os.path.join(WS, "state", "platform_index.meta.json")
PAGE = 200

_WORD = re.compile(r"[A-Za-z_][A-Za-z0-9_']*")
_DECL = re.compile(r"\b(?:theorem|lemma|def)\s+([A-Za-z_][A-Za-z0-9_'.]*)")
_LINE_COMMENT = re.compile(r"--[^\n]*")


_NAMEARD = re.compile(
    r"^(theorem|lemma|def|abbrev|structure|class|instance)\s+[A-Za-z_][A-Za-z0-9_'.]*")
_PROOF = re.compile(r":=\s*by\b.*$", re.S)


def norm_stmt(text):
    """Normalize a formal statement **with the declaration name stripped**.

    The platform stores `theorem <fully.qualified.name> <binders> : <type> := by
    sorry`, so the name is part of the text; keeping it would make every equality a
    name equality.  Stripping it yields the semantic statement, which is what a
    duplicate is: two differently-named theorems of the same type.
    """
    text = _LINE_COMMENT.sub(" ", text or "")
    text = re.sub(r"\s+", " ", text).strip()
    text = _PROOF.sub("", text).strip()
    text = _NAMEARD.sub(r"\1 _", text, count=1)
    return text.strip()


def decl_only(text):
    """The declaration text `theorem <name> … : …` with the proof cut off."""
    t = re.sub(r"\s+", " ", _LINE_COMMENT.sub(" ", text or "")).strip()
    m = _DECL.search(t)
    if not m:
        return ""
    tail = t[m.start():]
    cut = min([i for i in (tail.find(":= by"), tail.find(":= "), tail.find(":=by"))
               if i >= 0] or [len(tail)])
    return tail[:cut].strip()


def sig(text):
    """Token multiset signature — binder-name-insensitive near-match key."""
    toks = sorted(set(_WORD.findall(text)))
    toks = [t for t in toks if t not in _KEYWORDS]
    return hashlib.sha1(" ".join(toks).encode()).hexdigest()


_KEYWORDS = {
    "theorem", "lemma", "def", "by", "sorry", "import", "open", "scoped",
    "namespace", "end", "section", "variable", "noncomputable", "instance",
    "set_option", "Mathlib", "in", "with", "fun", "let", "have", "show",
    "from", "exact", "apply", "rw", "simp", "Classical",
}


def h(text):
    return hashlib.sha1(text.encode()).hexdigest()


def index_chunk(pages):
    meta = {"next_offset": 0, "total": None, "done": False}
    if os.path.exists(META):
        meta.update(json.load(open(META)))
    if meta.get("done"):
        print(f"index complete: {meta['total']} theorems")
        return 0
    seen = set()
    if os.path.exists(INDEX):
        with open(INDEX) as fh:
            for line in fh:
                try:
                    seen.add(json.loads(line)["theorem_id"])
                except Exception:
                    pass
    n0, off = 0, meta["next_offset"]
    t0 = time.time()
    out = open(INDEX, "a")
    for _ in range(pages):
        body = up.api("GET", "theorems",
                      params={"limit": PAGE, "offset": off, "sort": "newest"})
        rows = (body or {}).get("theorems") or []
        total = (body or {}).get("total")
        if total:
            meta["total"] = total
        if not rows:
            meta["done"] = True
            break
        for r in rows:
            tid = r.get("theorem_id")
            if tid in seen:
                continue
            seen.add(tid)
            stmt = norm_stmt(r.get("formal_statement"))
            rec = {
                "id": tid,
                "name": r.get("theorem_name"),
                "status": r.get("status"),
                "author": r.get("created_by_username"),
                "by": r.get("created_by"),
                "leaf": (r.get("theorem_name") or "").split(".")[-1],
                "sem": stmt[:700],
                "sh": h(stmt),
                "dh": h(decl_only(r.get("formal_statement"))) if stmt else "",
                "sg": sig(stmt),
            }
            out.write(json.dumps(rec) + "\n")
            n0 += 1
        off += len(rows)
        if total is not None and off >= total:
            meta["done"] = True
            break
    out.close()
    meta["next_offset"] = off
    json.dump(meta, open(META, "w"))
    print(f"+{n0} rows in {time.time() - t0:.0f}s  offset={off}/{meta.get('total')}  "
          f"done={meta['done']}")
    return 0


def load_index():
    rows = []
    with open(INDEX) as fh:
        for line in fh:
            rows.append(json.loads(line))
    return rows


def declared_name(text):
    """The *declared* name in a stub (`theorem <name> …`), comments stripped.

    For a primed slug the platform's `theorem_name` validator rejects the prime, so the
generated stub declares the prime-free name (`…sum_le_alt`) while the wave slug keeps the
`…sum_le'` handle.  Comparing the platform name against `meta['name']` would then report the
same node as a duplicate of itself, so the collision test uses the name actually declared.
    """
    m = _DECL.search(_LINE_COMMENT.sub(" ", text or ""))
    return m.group(1) if m else None


def local_theorems():
    """(slug, dotted name, statement, decl) for every Theorems/*.lean stub."""
    d = json.load(open(os.path.join(WS, "pipeline", "wave_upload.json")))
    thms = d.get("thms", {})
    out = []
    tdir = os.path.join(WS, "Theorems")
    for slug, meta in thms.items():
        path = os.path.join(tdir, f"Thm_{slug}.lean")
        try:
            text = open(path).read()
        except OSError:
            continue
        stmt = norm_stmt(text)
        out.append({
            "slug": slug,
            "name": meta.get("name"),
            "declname": declared_name(text),
            "chapter": meta.get("chapter"),
            "sh": h(stmt),
            "dh": h(decl_only(text)),
            "sg": sig(stmt),
            "leaf": (meta.get("name") or slug).split(".")[-1],
        })
    return out


_TOP_DECL = re.compile(
    r"^(?:@\[[^\]]*\]\s*)?(?:theorem|lemma|def|abbrev)\s+([A-Za-z_][A-Za-z0-9_']*)", re.M)
_BLOCK_COMMENT = re.compile(r"/-(?:[^/]|/(?!-))*?-/", re.S)


def module_decls(path, namespace=""):
    """(name, statement, decl) for every top-level declaration of a Lean **module**.

    The wave pass (`local_theorems`) reads the generated `Theorems/Thm_*.lean` stubs, so a
    new addition that is *not* yet in the wave has no stub to read.  This reads the
    declarations straight from the source instead, which is the reuse check the rule
    requires for every new addition (statement, declaration text, token signature, dotted
    name and leaf name against the cached catalogue).

    Approximation: the declaration text is cut at the first `:= by` / `:= ` (as in
    `decl_only`), and block/doc comments are stripped, so hashes are comparable with the
    platform's `formal_statement` only for statements whose type comes before the `:=`.
    Names and leaf names are exact.
    """
    src = _BLOCK_COMMENT.sub(" ", open(path).read())
    hits = list(_TOP_DECL.finditer(src))
    out = []
    for k, m in enumerate(hits):
        end = hits[k + 1].start() if k + 1 < len(hits) else len(src)
        block = src[m.start():end]
        decl = decl_only(block)
        stmt = norm_stmt(decl)
        out.append({
            "slug": m.group(1),
            "name": f"{namespace}.{m.group(1)}" if namespace else m.group(1),
            "declname": m.group(1),
            "sem": stmt,
            "sh": h(stmt),
            "dh": h(decl),
            "sg": sig(stmt),
            "leaf": m.group(1),
        })
    return out


def module_report(path, namespace, max_examples):
    rows = load_index()
    locals_ = module_decls(path, namespace)
    print(f"module: {path}  namespace: {namespace or '-'}")
    print(f"platform index: {len(rows)} rows; local declarations parsed: {len(locals_)}")
    by_sh, by_dh, by_sig, by_name, by_leaf = {}, {}, {}, {}, {}
    for r in rows:
        by_sh.setdefault(r["sh"], []).append(r)
        if r["dh"]:
            by_dh.setdefault(r["dh"], []).append(r)
        by_sig.setdefault(r["sg"], []).append(r)
        by_name.setdefault(r["name"], []).append(r)
        by_leaf.setdefault(r["leaf"], []).append(r)
    cls = {"STMT": [], "DECL": [], "SIG": [], "NAME": [], "LEAF": []}
    for lt in locals_:
        for label, table, key in (("STMT", by_sh, "sh"), ("DECL", by_dh, "dh"),
                                  ("SIG", by_sig, "sg"), ("NAME", by_name, "name"),
                                  ("LEAF", by_leaf, "leaf")):
            val = lt.get(key)
            if not val:
                continue
            if label in ("STMT", "DECL", "SIG") and not lt["sem"]:
                continue
            for r in table.get(val, []):
                if r["name"] in (lt["name"], lt["declname"]):
                    continue
                cls[label].append((lt, r))
    skipped = [lt for lt in locals_ if not lt["sem"]]
    if skipped:
        print(f"note: {len(skipped)} declaration(s) without a comparable statement "
              f"(`abbrev`/`structure`; compared by NAME/LEAF only): "
              + ", ".join(lt["slug"] for lt in skipped[:8]))
    for label in ("STMT", "DECL", "SIG", "NAME", "LEAF"):
        hits = cls[label]
        others = [x for x in hits if x[1]["status"] == "Proved"]
        print(f"{label}: {len(hits)} collisions ({len(others)} with a Proved node)")
        for lt, r in hits[:max_examples]:
            print(f"    {lt['name']}  ->  {r['name']} [{r['status']}/{r['author']}]")
    return 0


def report(max_examples):
    rows = load_index()
    meta = json.load(open(META)) if os.path.exists(META) else {}
    locals_ = local_theorems()
    print(f"platform index: {len(rows)} rows (meta total={meta.get('total')}, "
          f"done={meta.get('done')})")
    print(f"local wave theorems parsed: {len(locals_)}")
    print("match classes: STMT (same normalized statement), DECL (same declaration "
          "text), SIG (same token set, binder-renamed/near), NAME (same dotted name), "
          "LEAF (same last name component).\n")

    by_sh, by_dh, by_sig, by_name, by_leaf, me = {}, {}, {}, {}, {}, {}
    for r in rows:
        by_sh.setdefault(r["sh"], []).append(r)
        if r["dh"]:
            by_dh.setdefault(r["dh"], []).append(r)
        by_sig.setdefault(r["sg"], []).append(r)
        by_name.setdefault(r["name"], []).append(r)
        by_leaf.setdefault(r["leaf"], []).append(r)
        me.setdefault(r["by"], set()).add(r["author"])

    # 1. within-platform duplicates across authors (reuse candidates)
    cross = [g for g in by_sh.values()
             if len({x["author"] for x in g}) > 1]
    print(f"[A] platform statement-duplicate groups spanning >1 author: {len(cross)}")
    for g in sorted(cross, key=lambda g: -len(g))[:max_examples]:
        print("    " + " | ".join(
            f"{x['name']} [{x['status']}/{x['author']}]" for x in g[:4]))

    # 2. local theorems that collide with the platform
    cls = {"STMT": [], "DECL": [], "SIG": [], "NAME": [], "LEAF": []}
    for lt in locals_:
        checks = [("STMT", by_sh, "sh"), ("DECL", by_dh, "dh"), ("SIG", by_sig, "sg"),
                  ("NAME", by_name, "name"), ("LEAF", by_leaf, "leaf")]
        for label, table, key in checks:
            val = lt.get(key)
            if not val:
                continue
            for r in table.get(val, []):
                # Itself: same wave name, or the same declaration under the
                # validator's prime-free name (a primed slug).
                if r["name"] == lt["name"] or r["name"] == lt.get("declname"):
                    continue
                cls[label].append((lt, r))
    print()
    for label in ("STMT", "DECL", "SIG", "NAME", "LEAF"):
        hits = cls[label]
        others = [x for x in hits if x[1]["status"] == "Proved"]
        print(f"[B] {label}: {len(hits)} collisions "
              f"({len(others)} with a Proved node) "
              f"— sample:")
        for lt, r in hits[:max_examples]:
            print(f"    {lt['slug']}  ->  {r['name']} [{r['status']}/{r['author']}]")

    # 3. how many local theorems already exist by name in the platform (self-dedup)
    inexact = [lt for lt in locals_ if lt["name"] in by_name]
    print(f"\n[C] local wave theorems whose dotted name already exists on the "
          f"platform: {len(inexact)} / {len(locals_)}")
    for lt in inexact[:max_examples]:
        r = by_name[lt["name"]][0]
        print(f"    {lt['name']}  [{r['status']}/{r['author']}]")
    return 0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--index", action="store_true")
    ap.add_argument("--report", action="store_true")
    ap.add_argument("--reset", action="store_true", help="discard the cached index")
    ap.add_argument("--pages", type=int, default=100000)
    ap.add_argument("--max", type=int, default=15)
    ap.add_argument("--module", help="Lean file whose top-level declarations to classify")
    ap.add_argument("--namespace", default="", help="namespace prefix for --module names")
    args = ap.parse_args()
    if args.reset:
        for p in (INDEX, META):
            if os.path.exists(p):
                os.remove(p)
        print("index reset")
        if not args.index:
            return 0
    if args.index:
        ok, version, detail = up.auth_probe()
        print(f"auth ok={ok} version={version} {detail}")
        if not ok:
            return 2
        return index_chunk(args.pages)
    if args.report:
        return report(args.max)
    if args.module:
        return module_report(args.module, args.namespace, args.max)
    ap.print_help()
    return 0


if __name__ == "__main__":
    sys.exit(main())
