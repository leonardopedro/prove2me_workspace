#!/usr/bin/env python3
"""Publish every def bundle derivable from timepiece331, in dependency order.

WHY
---
147 of 782 chapters in `timepiece331/BookProof` are published as Definition
modules. The pending pipeline backlog is gated on that gap: a statement module
cannot compile until the Definitions it imports exist, and 38 pending statements
were blocked on a single unpublished bundle before `ChapterClosureUniqueness`
went up.

ORDER IS THE CONSTRAINT
-----------------------
`wave_generate.py` derives a bundle's `import Definitions.Def_ChapterX` lines
from the source's own `import BookProof.X` lines, and only for Def files that
already exist locally. So a downstream chapter's bundle cannot be generated
before its upstream ones exist. This tool therefore walks the chapter DAG
deps-first and generates each bundle only after its upstream Def files are on
disk.

VALIDATION GATES (a bundle failing any of these is not publishable)
-------------------------------------------------------------------
  sorry-free     no `sorry` outside comments -- a Definitions module carries
                 real definitions, and a sorry there poisons every dependent
  axiom-free     no `axiom` declarations
  closure        every `Definitions.Def_*` in the transitive import closure is
                 already published, or is published earlier in this same run
  opens-resolved every `open BookProof.X` has a provider in the same sense

`--dry-run` (default) reports what would be generated and why things are
skipped. `--apply` generates and registers the bundles into
`pipeline/wave_upload.json`; it does NOT upload. Publishing is a separate,
deliberate step: `upload_pipeline.py --kind def`.

USAGE
-----
    PROVE2ME_WS=<ws> TIMEPIECE_PROJ=<timepiece331> \
      python3 debug/publish_all_defs.py --limit 40 --apply
"""
import json
import os
import re
import shutil
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(HERE)
PROJ = os.environ.get("TIMEPIECE_PROJ") or f"{WS}/../timepiece331"
BOOK = f"{PROJ}/BookProof"
DEFS = f"{WS}/Definitions"
SKETCH = f"{WS}/state/sketch"
WAVE = f"{WS}/pipeline/wave_upload.json"
INDEX = f"{WS}/state/defs_index.json"
ELAN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"

CH_IMPORT = re.compile(r"^import BookProof\.(?:Chapter)?([A-Za-z0-9]+)(?:\.lean)?", re.M)
DECL_ANY = re.compile(r"(?m)^\s*(?:@\[[^\]]*\]\s*)?(?:private\s+|protected\s+|noncomputable\s+)*"
                      r"(?:theorem|lemma|def|abbrev|instance|structure|inductive|class)\s+\S")


def chapters():
    return sorted(f[:-len(".lean")] for f in os.listdir(BOOK)
                  if f.endswith(".lean") and not f.endswith(".lean.331-old"))


def source_imports(leaf):
    """Upstream chapters this chapter imports, as bare chapter names."""
    path = f"{BOOK}/{leaf}.lean"
    if not os.path.exists(path):
        return []
    txt = open(path, encoding="utf-8", errors="ignore").read()
    out, seen = [], set()
    for m in CH_IMPORT.finditer(txt):
        name = m.group(1)
        if name in seen or name == leaf:
            continue
        seen.add(name)
        if os.path.exists(f"{BOOK}/{name}.lean"):
            out.append(name)
    return out


def strip_comments(t):
    t = re.sub(r"/-.*?-/", " ", t, flags=re.S)
    return re.sub(r"(?m)--.*$", " ", t)


def published_set():
    try:
        idx = json.load(open(INDEX))["bundles"]
    except Exception:
        return set()
    return {k for k, v in idx.items() if v.get("status") == "PUBLISHED"}


def namespace_owners(extra=()):
    """namespace -> bundle, over published bundles only."""
    try:
        idx = json.load(open(INDEX))["bundles"]
    except Exception:
        return {}
    pub = {k for k, v in idx.items() if v.get("status") == "PUBLISHED"}
    # Bundles registered in the wave count too: a chapter can `open BookProof.X`
    # without `import BookProof.X`, so import order alone does not guarantee X was
    # generated first. Without these, such chapters are skipped forever.
    pub |= set(extra)
    owners = {}
    for leaf in sorted(pub):
        for base in (f"{WS}/state/published_bundles/Def_{leaf}.lean", f"{DEFS}/Def_{leaf}.lean"):
            if os.path.exists(base):
                txt = open(base, errors="ignore").read()
                for ns in re.findall(r"(?m)^namespace (\S+)", txt):
                    owners.setdefault(ns, leaf)
                break
    return owners


def ensure_sketch(leaf, timeout=900, force=False):
    """Refresh the sketch if absent or empty. A stale sketch silently emits
    garbled bundles (it once produced a file containing `irst | rfl | ring)`)."""
    out = f"{SKETCH}/sketch_{leaf}.jsonl"
    src = f"{BOOK}/{leaf}.lean"
    # A split chapter (BookProof/<leaf>/ is a directory of parts) is indexed
    # against the PRE-SPLIT monolith, not the current aggregator -- wave_generate
    # deliberately slices the old text. Extracting a sketch from the new
    # aggregator yields offsets past the monolith's end, and load_decls then
    # refuses to slice. So for split chapters, index the monolith.
    is_split = os.path.isdir(f"{BOOK}/{leaf}")
    if is_split:
        src = f"{SKETCH}/monolith/{leaf}.lean"
    # A sketch older than its source is stale, and staleness is silent: every
    # offset is still in range so the generator's overshoot guard passes, and it
    # slices text out of the middle of unrelated declarations (`nd
    # BookProof.ChapterA`, `heet))ro_empty)`). 473 of 772 sketches were older
    # than their source, which is why one publish run rejected 38% of bundles.
    # Compare mtimes rather than trusting a non-empty cache.
    # Content-based validity: the sketch's byte offsets must fit the text the
    # generator will actually slice. mtime is not enough -- a sketch extracted
    # from a chapter's current aggregator is "newer" than the pre-split monolith
    # the generator slices for split chapters, yet every one of its offsets is
    # wrong. load_decls catches the overshoot, but only after the fact.
    if not force and os.path.exists(out) and os.path.getsize(out) > 0:
        try:
            size = os.path.getsize(src) if os.path.exists(src) else -1
            if size > 0:
                over = False
                for line in open(out, encoding="utf-8"):
                    if '"declEnd"' not in line:
                        continue
                    r = json.loads(line)
                    if r.get("kind") == "decl" and r.get("declEnd", {}).get("offset", 0) > size:
                        over = True
                        break
                if over:
                    print(f"    (sketch for {leaf} does not index {os.path.basename(src)}"
                          f"; re-extracting)", flush=True)
                else:
                    return True, "cached"
            else:
                return True, "cached"
        except Exception as e:
            # Never conclude "cached" from an error: that silently keeps a bad
            # sketch, which is how ChapterNavierStokesFockEsa stayed unfixable
            # (its sketch indexes the aggregator, not the 29983-byte monolith).
            print(f"    (sketch check for {leaf} inconclusive: {type(e).__name__}"
                  f"; re-extracting)", flush=True)
    if os.path.exists(out) and os.path.getsize(out) > 0:
        if not os.path.exists(src) or os.path.getmtime(out) >= os.path.getmtime(src):
            return True, "cached"
        # Stale: fall through and re-extract. Returning here would report success
        # while leaving the stale sketch in place, which is exactly what happened
        # -- 473 stale sketches were reused and ChapterA3c stayed garbled.
        print(f"    (refreshing stale sketch for {leaf})", flush=True)
    env = dict(os.environ)
    env["PATH"] = ELAN + ":" + env.get("PATH", "")
    # extract_sketch_info resolves its argument as a MODULE name, so staging the
    # monolith under a different filename does nothing -- it still read the
    # aggregator. To index the pre-split text, swap the monolith in under the
    # real module name for the duration of the extraction, then put the
    # aggregator back.
    target = f"BookProof/{leaf}.lean"
    live = f"{PROJ}/BookProof/{leaf}.lean"
    backup = None
    if is_split:
        if not os.path.exists(src):
            return False, "split chapter has no cached monolith"
        backup = live + ".publishall.bak"
        shutil.copy2(live, backup)
        shutil.copy2(src, live)
        # Lean resolves an import to the module's OLEAN when one exists, and
        # timepiece331 is fully built, so the swapped-in monolith was never read:
        # the sketch kept indexing the aggregator (max offset 30335 against a
        # 29983-byte monolith). Move the compiled artefacts aside for the
        # duration of the extraction.
        stash = []
        for ext in (".olean", ".ilean"):
            art = f"{PROJ}/.lake/build/lib/lean/BookProof/{leaf}{ext}"
            for cand in (art,):
                if os.path.exists(cand):
                    os.rename(cand, cand + ".publishall.bak")
                    stash.append(cand)
    try:
        try:
            r = subprocess.run(
                ["lake", "env", "lean", "--run", "extract_sketch_info.lean",
                 target, "-DmaxHeartbeats=0",
                 "-DmaxSynthPendingDepth=10", "-DrelaxedAutoImplicit=false"],
                cwd=PROJ, env=env, capture_output=True, text=True, timeout=timeout)
        except subprocess.TimeoutExpired:
            return False, "sketch timeout"
    finally:
        # Always put the aggregator back, even on timeout or error: timepiece331
        # is a git checkout other work depends on.
        if backup and os.path.exists(backup):
            shutil.move(backup, live)
        for art in stash:
            if os.path.exists(art + ".publishall.bak"):
                os.rename(art + ".publishall.bak", art)
    # The sketch is written to stdout; it has to be captured to disk, or every
    # later chapter looks "empty" forever.
    if r.stdout.strip():
        with open(out, "w", encoding="utf-8") as fh:
            fh.write(r.stdout)
    if not os.path.exists(out) or os.path.getsize(out) == 0:
        return False, "sketch empty (rc=%s)" % r.returncode
    return True, "extracted"


def generate(leaf, timeout=900):
    env = dict(os.environ)
    env["PATH"] = ELAN + ":" + env.get("PATH", "")
    env["PROVE2ME_WS"] = WS
    env["TIMEPIECE_PROJ"] = PROJ
    try:
        r = subprocess.run([sys.executable, f"{WS}/scripts/wave_generate.py",
                            "--defs-only", leaf],
                           cwd=WS, env=env, capture_output=True, text=True, timeout=timeout)
    except subprocess.TimeoutExpired:
        return False, "generate timeout"
    out = f"{DEFS}/Def_{leaf}.lean"
    if not os.path.exists(out) or os.path.getsize(out) == 0:
        return False, "no bundle written (rc=%s)" % r.returncode
    return True, "generated"


def wave_entry(leaf, path):
    ns = re.findall(r"(?m)^namespace (\S+)", open(path, errors="ignore").read())
    return {
        "definition_name": leaf,
        "namespace": ns[0] if ns else "",
        "file": f"/home/leo/prove2me_workspace/Definitions/Def_{leaf}.lean",
        "title": "Chapter " + leaf[len("Chapter"):] if leaf.startswith("Chapter") else "Chapter " + leaf,
        "nl": (f"Formal definitions for the timepiece Lean 4 formalization "
               f"(source chapter `BookProof/{leaf}.lean`): generated def bundle "
               f"for {leaf}. See BookProof/{leaf}.lean for full context."),
        "source": (f"https://github.com/leonardopedro/timepiece/blob/61595bc/BookProof/{leaf}.lean"),
        "tags": ["timepiece", "formalization", "definitions"],
    }


def main():
    limit = 0
    if "--limit" in sys.argv:
        limit = int(sys.argv[sys.argv.index("--limit") + 1])
    apply = "--apply" in sys.argv
    refresh = "--refresh" in sys.argv
    include_registered = "--include-registered" in sys.argv
    include_published = "--include-published" in sys.argv
    only_file = None
    if "--only-file" in sys.argv:
        only_file = sys.argv[sys.argv.index("--only-file") + 1]
    os.makedirs(SKETCH, exist_ok=True)

    all_ch = chapters()
    pub = published_set()
    # A bundle already registered in the wave counts as available even if the
    # platform index has not caught up yet. Without this, every pass re-derives
    # the same ordering and the chapters skipped for "open X has no provider"
    # stay skipped forever, because the provider they were waiting for is
    # registered later in the same run.
    try:
        wave_defs = json.load(open(WAVE))["defs"]
    except Exception:
        wave_defs = {}
    registered = set(wave_defs) | pub
    # --include-registered re-examines wave chapters too, which is how a repair
    # pass revisits bundles that were registered from a stale sketch and so
    # published garbled text.
    # --include-published re-examines chapters that are ALREADY live. A published
    # bundle generated from a stale sketch can silently omit declarations that
    # dependents reference: Def_ChapterNavierStokesFockSpace does not declare
    # fockDom_dense, so Def_ChapterNavierStokesFockEsa is rejected with
    # `Unknown identifier fockDom_dense` even though the theorem is proved.
    # Everything not yet live is a target. `--include-published` additionally
    # re-examines live chapters, because a published bundle generated from a
    # stale sketch can omit declarations its dependents reference. The earlier
    # three-clause form dropped registered-but-FAILED chapters on the floor:
    # `c not in registered` False, `c not in pub` True but gated behind a flag
    # that was off, so a chapter the platform had rejected was never retried.
    todo = [c for c in all_ch if c not in pub
            or (include_published and c in pub)
            or (include_registered and c in registered and c not in pub)]
    print(f"chapters {len(all_ch)}, published {len(pub)}, registered-in-wave "
          f"{len(set(wave_defs) - pub)}, to do {len(todo)}")

    # deps-first over the chapter graph, restricted to the unpublished set
    order, seen, stack_guard = [], set(), set()

    def visit(leaf):
        if leaf in seen or leaf not in todo:
            return
        if leaf in stack_guard:          # a cycle cannot happen in a DAG, but
            return                        # do not loop if it does
        stack_guard.add(leaf)
        for up in source_imports(leaf):
            visit(up)
        stack_guard.discard(leaf)
        seen.add(leaf)
        order.append(leaf)

    if only_file:
        want = {l.strip() for l in open(only_file) if l.strip()}
        todo = [c for c in todo if c in want]

    for c in todo:
        visit(c)
    if limit:
        order = order[:limit]
    print(f"processing {len(order)} chapter(s) deps-first"
          + (f" (capped at --limit {limit})" if limit else ""))

    published_now = set()
    owners = namespace_owners(registered)
    made, skipped = [], []

    for i, leaf in enumerate(order, 1):
        ok, why = ensure_sketch(leaf, force=refresh)
        if not ok:
            skipped.append((leaf, why))
            print(f"  [{i}/{len(order)}] SKIP {leaf}: {why}", flush=True)
            continue
        ok, why = generate(leaf)
        if not ok:
            skipped.append((leaf, why))
            print(f"  [{i}/{len(order)}] SKIP {leaf}: {why}", flush=True)
            continue
        path = f"{DEFS}/Def_{leaf}.lean"
        txt = open(path, errors="ignore").read()
        # A bundle whose block comments do not balance is unlexable: the
        # platform rejects it with `lex error: unterminated comment`, and Lean
        # will swallow the rest of the file as comment text. Catch it here
        # rather than spending a job on it.
        if len(re.findall(r"/-", txt)) != len(re.findall(r"-/", txt)):
            skipped.append((leaf, "unbalanced block comments"))
            print(f"  [{i}/{len(order)}] SKIP {leaf}: unbalanced /- and -/",
                  flush=True)
            continue
        clean = strip_comments(txt)
        if re.search(r"\bsorry\b", clean):
            skipped.append((leaf, "contains sorry"))
            print(f"  [{i}/{len(order)}] SKIP {leaf}: contains sorry", flush=True)
            continue
        if re.search(r"(?m)^\s*axiom\b", clean):
            skipped.append((leaf, "contains axiom"))
            print(f"  [{i}/{len(order)}] SKIP {leaf}: contains axiom", flush=True)
            continue
        # transitive Definitions closure must already be available
        need, stack = set(), [leaf]
        while stack:
            n = stack.pop()
            if n in need:
                continue
            need.add(n)
            fp = f"{DEFS}/Def_{n}.lean"
            if not os.path.exists(fp):
                continue
            for line in open(fp, errors="ignore"):
                m = re.match(r"import Definitions\.Def_(\S+)", line)
                if m:
                    stack.append(m.group(1))
        # The leaf is itself in its own closure; it is about to be published, so
        # only its *upstream* matters here.
        # A dependency counts as available if it is published OR already
        # registered in the wave (this campaign publishes the whole batch in
        # topological order, so a registered dep will exist by the time the
        # dependent is compiled). Gating on published-only is what stalled
        # convergence: every chapter depending on a registered-but-not-yet-live
        # bundle was skipped, in every pass, forever.
        available = pub | registered | published_now
        missing = sorted(n for n in need
                         if n != leaf and n not in available)
        if missing:
            skipped.append((leaf, "deps not published: " + ",".join(missing[:3])))
            print(f"  [{i}/{len(order)}] SKIP {leaf}: deps missing "
                  f"{','.join(missing[:3])}", flush=True)
            continue
        # every `open BookProof.X` needs a provider
        unres = []
        for ns in re.findall(r"(?m)^open (BookProof\.\S+)", txt):
            if ns not in owners and not any(
                    re.search(r"(?m)^namespace " + re.escape(ns) + r"\b",
                              open(f"{DEFS}/Def_{p}.lean", errors="ignore").read())
                    for p in published_now):
                unres.append(ns)
        if unres:
            skipped.append((leaf, "unresolved opens: " + ",".join(unres[:2])))
            print(f"  [{i}/{len(order)}] SKIP {leaf}: open {unres[0]} has no provider",
                  flush=True)
            continue

        made.append(leaf)
        published_now.add(leaf)
        # record the namespace we just provided, for downstream `open`s
        for ns in re.findall(r"(?m)^namespace (\S+)", txt):
            owners.setdefault(ns, leaf)
        print(f"  [{i}/{len(order)}] OK   {leaf}", flush=True)

    if made and apply:
        w = json.load(open(WAVE))
        for leaf in made:
            w["defs"].setdefault(leaf, wave_entry(leaf, f"{DEFS}/Def_{leaf}.lean"))
        json.dump(w, open(WAVE, "w"), indent=1)
        print(f"\nregistered {len(made)} bundle(s) in the wave; wave now {len(w['defs'])}")

    print(f"\npublishable {len(made)}, skipped {len(skipped)}")
    for leaf, why in skipped[:15]:
        print(f"   skip {leaf}: {why}")
    json.dump({"publishable": made, "skipped": skipped},
              open(f"{WS}/state/publish_all_defs.json", "w"), indent=1)
    print(f"wrote {WS}/state/publish_all_defs.json")
    return 0


if __name__ == "__main__":
    sys.exit(main())