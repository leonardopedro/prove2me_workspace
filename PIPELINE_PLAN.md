# Timepiece → Prove2me Transplant — Runbook

Handoff document for ANY agent (opencode, Claude Code, Codex, plain CLI model) continuing
the transplant of the **timepiece** Lean 4 project onto **prove2.me**.

- **This file = current state + operating procedures only.** No session history.
- **Full historical record** (session logs, failed approaches, incident post-mortems):
  `PIPELINE_PLAN_LEGACY.md` — consult it only for archaeology, never for instructions.
- **Authoritative references**: `SKILL.md` (API schemas, upload policy, three basic
  rules), `references/prove2me-lean4.33-translation/PLAN_LEAN4_33_TRANSLATION.md`
  (v4.28→v4.33.1 drift catalogue), `references/upload_full_project.md` (phases 0–6).

---

## 1. CURRENT TASK — upstream-def publication wave

Publish the **66 upstream def bundles** (dependency closure of the 4 deferred
chapters) plus the 4 deferred chapters themselves
(SirkEndToEnd, SirkWhitening, SirkPerSystem, YangMillsHermite) with their thm/sol
nodes. This unlocks everything the earlier waves deferred.

### 1a. VERIFIED STATE (2026-09-12, Freebuff cloud sandbox — supersedes the counts below)

Measured against the live platform (API 0.10.3), not from log archaeology:

- Wave spec: **111 defs / 890 thms / 890 sols** (`pipeline/wave_upload.json`); `ORDER` = 1907 in-plan items.
- Platform holds **119 published definitions** and **722 published problems** for this account
  (`leonardopedro`); `state/pipeline.json` reconciled to **1082 done / 788 pending / 0 failed** by
  `--sync` (653 items were still marked pending locally while already published upstream).
- **Platform envelope changed in 0.10.x**: `GET /publish-jobs` returns `{publish_jobs, total}`, not
  `{jobs}`; `GET /theorems?tags=…` returns 400. **Neither is documented in the 0.10.3 skill** — the
  uploader accepts any list-valued envelope key, and `debug/api_probe.py` prints raw shapes.
- **Skill/repo sync (done 2026-09-12)**: the fork was already merged with
  `prove2me/prove2me_workspace` (merge commit `482ff33`); only the sandbox checkout lagged. Synced with
  `git remote add upstream … && git fetch upstream --tags && git merge --ff-only origin/main`
  (clean fast-forward, no local work touched). Skill version now matches the platform
  (**0.10.3 / 0.10.3**), and `references/campaigns.md` (0.9.9 feature) arrived. Upstream carries only
  the skill; the fork adds `BookProof/ Definitions/ Theorems/ Solutions/ pipeline/ state/`.
  The fork's `main` is its only branch and does **not** contain the missing stubs below — those were
  never committed (the Wave-10 commit message claims +74, but 0 exist in any ref).
- **Chunked mode added** to `pipeline/upload_pipeline.py` for hosts that cannot run a daemon:
  `--check` (auth + inventory), `--status` (plan vs state + unsubmittable list), `--sync`
  (reconcile from publish jobs, exits), `--dry-run`, `--max-items N` / `--max-seconds S`
  (bounded run, exits 0 at the bound). `WS`/`LAKE_BIN`/`PROVE2ME_API_KEY`/`PROVE2ME_WS` are
  env-overridable; wave-spec absolute paths are re-rooted onto the checkout.
- **Job-poll states no longer consume an attempt** (`still in flight`, `poll timeout`): a big bundle
  idling for minutes is normal (§3) and must not burn one of the 5 attempts. Chunks use
  `--job-timeout 25..40` so a bounded run returns cleanly; the saved `job_id` is re-polled next run.
- **Per-kind runs + preflight guard**: `--kind def|thm|sol` (repeatable) because a blocked def at the
  head of `ORDER` starves everything behind it in a bounded chunk. Before every submission the runner
  skips (no attempt consumed) any item importing an **unpublished** def bundle — §2 makes that a
  guaranteed server FAILED. `--no-preflight` disables it.
- **GENERATOR/DATA BUG — `theorem_title` cap is 200 *bytes*, not 200 characters**: the server rejects
  the whole submission (`theorem_title must be at most 200 characters` — the message says characters,
  the enforcement is UTF-8 bytes). The wave spec lifted titles verbatim from chapter docstrings, so
  **131 of 890 thm titles** were over the character count; clamping by character still left **86
  pending titles over the byte cap**, because these titles are full of multi-byte math symbols
  (proof: `BookProof_ChapterSirkTrotterKato_tendsto_uniformly_on_isCompact_of_tendsto` — 200 chars,
  247 bytes, rejected; also `𝓝`, `∀`, `→`, `ε`, `ᶠ`). `clamp_title()` now clips on the *encoded*
  length at a word boundary without splitting a character; 0 of the 193 pending titles violate it.
  Root cause is generator-side: for many items `wave_meta.json`'s `title` is a raw *type signature*
  (binders + conclusion), not a human label — worth fixing in `scripts/wave_generate.py` for future
  waves, since a title is display-only and can be freely rewritten.
- **Chunk progress — running totals**: state **1088 → 1174 done / 697 pending / 0 failed** this
  session (defs 112/0 pending — the whole def layer done). Thms published all `DONE`:
  SirkCertifiedGap ×6, SirkGapTable ×3, SignedShift, RitzPerturbation ×4, ChapterH1 ×3, ChapterH4,
  ChapterH8, ChapterSirkGramCutoff, ChapterSirkGramWhitening ×2, ChapterSirkSpectralGeometry,
  ChapterSirkTruncation ×2, NavierStokesFlow ×6, FockSecondQuantization, FockOneParticleGap,
  RitzMinMax, +7 in flight. Thm kind went **651 → 676 done / 190 pending, 0 failed**. No item has
  been marked `failed` by the runner. One submit was rejected by the byte-cap bug above (1 attempt).
  `--kind thm --parallel 10` resolved **18 items in 139 s**.
- **Pipelined mode (`--parallel N`)**: the server spends ~20-30 s compiling each submission and the
  sequential loop slept away most of that per item (36 s/item → 4 items per 150 s chunk). With
  `--parallel N`, `do_*` returns as soon as the job is accepted and every in-flight job is polled in
  one round: measured **8 items per 141-150 s**, and `--parallel 12` holds 12. Verdict semantics are
  unchanged (`done` only on PUBLISHED/ACCEPTED), so an item still compiling when a chunk is cut off
  stays `pending` with its id and is re-polled next run at no attempt cost. Sequential remains the
  default path. **Two mis-labelled logs to know about**: `submitting X (attempt n)` is printed before
  dispatch, so a re-poll of an existing job is logged with the same wording.
- **A server-side flake cost one attempt**: `publish FAILED: formal statement does not compile:
  Import parser timed out after 5s` on `thm:BookProof_FriedrichsFormGap_friedrichs_quadForm_lower_bound`
  — it **passed on the next attempt unchanged**, so that one is a transient import-parser timeout, not a
  property of the node. Left out of `TRANSIENT_ERRORS` deliberately: unlike a job poll it could also be
  deterministic for a huge import closure, and silently retrying it forever would hide a real failure.
- **`--only SUBSTR`** (repeatable) restricts a run to matching items; needed because a blocking node
  can sit near the end of the deps-first `ORDER` (the QgHermite chain is at ~1689/1908). Composes with
  `--kind`, `--dry-run` and `--parallel`.
- **A dependency wait must never cost an attempt**: `not published yet` (a sol whose target theorem is
  still pending) is now in `TRANSIENT_ERRORS` alongside `still in flight` / `poll timeout`. Before
  this, a `--kind sol` chunk would have burned one attempt on each of the 551 pending sols whose
  theorem had not published yet. Waits also no longer consume the chunk's `--max-items` budget.
- **FIXED — duplicate sol submissions**: `do_wave_sol` had no re-poll path (unlike `do_wave_thm`), so
  every chunk re-submitted every sol still compiling, i.e. a fresh proof check per run. It now
  re-polls a recorded `submission_id` and only re-submits when the verdict is terminal. A terminal
  *failed* verdict now also drops its `job_id`/`submission_id`, otherwise each later run re-read the
  same dead verdict and spent an attempt without submitting anything (fixed in both the pipelined
  drain and the sequential loop). Sol proofs take **>150 s** to verify, so a single bounded chunk
  usually cannot both submit and drain them — expect to resolve the previous chunk's batch.
- **Sol-side failure mode (not a pipeline bug)**: the first sols to reach a real verdict came back
  `CE: Compile error in your proof: … Unknown identifier \`sirk_error_decay_exponential\``
  (`sirk_error_tendsto_zero`, `numRange_compress_subset`, `nsDiffH_shiftInvert_selects`,
  `diagKR_hashimoto_selects`). The proofs reference sibling declarations from their source chapter
  that are not reachable in the platform compilation of that single node — the same class as the
  QgHermite def gap, and the same reason §5d's repair (import + open the corresponding
  `Theorems.Thm_*` / `Definitions.Def_*` module) applies. Affected: ChapterSirkEndToEnd (5),
  ChapterSirkPerSystem (5), YangMillsHermite (4) so far. Retrying unchanged cannot fix these; they
  need the imports added before they are worth another attempt.
- **CRITICAL PATH — RESOLVED 2026-09-12. The whole def layer is now published (112 done / 0 pending),
  and `--status` reports no items waiting on an unpublished def bundle.** The chain was
  `ChapterQgHermiteFriedrichs` → `ChapterGaussCoreQuadBounds` → `ChapterSqSumFarisLavine`, blocking
  44 thms + 44 sols. How it was actually unblocked — **this supersedes §8 and the earlier
  "embed the proof" conclusion**:
  1. The bundle is a **hollowed skeleton**: its imports were missing and `memLp_mul_pgFun_of_expBounded`
     (used inside `potLp`'s body) is declared in the source chapter
     (`BookProof/ChapterQgHermiteCore.lean:617`) and as a theorem node, but in **no** def bundle.
     §8's claim that the helper "was embedded in `Def_ChapterQgHermiteCore`" **is false**
     (`git log --all -S memLp_mul_pgFun_of_expBounded -- Definitions/` finds only the initial
     snapshot; that bundle has 4 declarations in every ref) — the embedding was never committed.
  2. **NEW PLATFORM RULE (verified, and the key to the unblock): a Definitions module MAY import a
     published Theorems module**, but *"Imported platform theorems must be **Proved** at submission
     time"* — merely being published (`Open`) is rejected. So the def declares
     `import Theorems.Thm_BookProof_QgHermiteCore_memLp_mul_pgFun_of_expBounded` and the existing
     `open BookProof.QgHermiteCore` makes the identifier resolve. **No proof has to be written into
     the bundle** — the proof already exists in `Solutions/Sol_BookProof_QgHermiteCore_*.lean`.
     Prefer this over embedding: it costs 0 compiler-less proof authoring.
  3. So the fix was to **prove the helper's sol first**, deps-first: the helper's sol chain is exactly
     3 nodes (`ExpBounded_nonneg_const` already Proved → `exists_exp_bound_mvPolyEval` →
     `memLp_mul_pgFun_of_expBounded`). Proving those 2 sols flipped both thms to `Proved`, after which
     the def compiled and GaussCoreQuadBounds → SqSumFarisLavine followed in order.
  4. Those nodes sit at **~position 1689 of 1908** in the deps-first `ORDER`, far out of reach of a
     bounded chunk — hence the new `--only SUBSTR` filter (repeatable), which restricts a run to
     matching items so a specific blocking node can be targeted. `--dry-run --only` previews the set.
  **Watch for this shape elsewhere**: a def whose body needs a lemma that lives in a theorem node. The
  recipe is (a) find the lemma, (b) confirm its thm node is published, (c) prove its sol (and its sol
  chain) until `Proved`, (d) add `import Theorems.Thm_<...>` + the right `open` to the def bundle.
- 65 plan items are unsubmittable from a partial checkout (missing sources): FockCanonical 28,
  FockManyMode 19 (Wave-10 stubs that were never written to disk), ContinuityUnitaryInfinite 13,
  ChapterH6/H8/H9 helpers.
- Tooling added: `debug/skill_compliance.py` (SKILL.md rules 1–3 + stub/name checks),
  `debug/api_probe.py` (raw envelopes), `debug/job_failures.py --gap` (failure causes + plan gap),
  `debug/def_closure.py` (unpublished dependencies, deps-first), `debug/external_refs.py`  (missing imports/opens), `debug/add_wave_def.py` (additive wave extender).

### 1c. Freebuff cloud sandbox runbook + stub-extension wave (2026-09-12, session 2)

**Workspace here is `/home/daytona/codebase`** (not the canonical `/home/leo/prove2me_workspace`);
`WS` is derived from the script location, and spec paths are re-rooted by `resolve_path`, so the
same spec and state work from this checkout. `credentials.json`/`.env` are gitignored — the key is
read from `PROVE2ME_API_KEY` first, and `--check` confirms it (0.10.3 / 0.10.3, `leonardopedro`).

**Operating model — why a run appears to "never finish", and what to do about it.**
The host terminal is *synchronous* (killed at the tool timeout: 30 s default, 180 s max) and there
is **no persistent background process** — `setsid nohup` / `start_upload.sh` / the systemd unit do
NOT survive the call, so the daemon of §3 is unusable here. Every run must therefore be a **bounded
chunk that returns on its own**:

```bash
cd /home/daytona/codebase
PROVE2ME_MAX_SECONDS=120 python3 pipeline/upload_pipeline.py \
    --kind thm --parallel 20 --max-seconds 95 --job-timeout 45
```

- `PROVE2ME_MAX_SECONDS` is the only bound that covers the **whole** process (catalogue preflight +
polls); `--max-seconds` alone only reaches the submit loop. Keep budget + preflight under the tool
timeout.
- No Lean toolchain in this checkout, so the local gate self-degrades to "skipped" (one warning)
and the platform compiler is the oracle; `PROVE2ME_SKIP_LOCAL_COMPILE=1` just silences it.
- A dropped tool connection (HTTP 502 from the transport) kills the process mid-chunk. Harmless:
state is saved per item and the job id is recorded **before** polling, so the next chunk re-polls it
at no attempt cost. Do not "clean up" afterwards.
- **Throughput measured:** `--parallel 20` resolves **15–23 items per ~100 s chunk** (vs 8–9 at
`--parallel 12`, 1–4 sequential). In steady state a chunk re-polls the previous chunk's in-flight
batch and refills back up to 20, so *keep calling chunks*; one chunk cannot both submit a sol and
see its verdict (sol proofs take >150 s).
- Never run `--sync`/`--check` unbounded: each reads 168 + ~2800 publish jobs (~15 s) and `--sync`
then issues one GET per pending solution. `--sync` in this session marked 7 already-`Proved` sols
done (the other ~150 pending sols have published-but-`Open` theorems and need real proofs).

**GAP FOUND & FIXED — the wave spec held only 890 of the 1437 generated stubs.**
`Theorems/` holds 1437 stubs; **440 of the 607 not in the wave target chapters whose def bundle is
already PUBLISHED**, and **439 of them have a solution file**. They were never added to the wave —
which is exactly why `debug/fix_sol_imports.py` reports their references as `status=absent`: the node
is absent because it was never *submitted*, not because it cannot exist. That also explains the two
chapters §1b left blocked (`GaussCoreQuadBounds`, `SqSumFarisLavine`): they are waiting on
`QgHermiteFriedrichs_*` / `HermiteProductCore_*` nodes whose stubs are sitting on disk.

**New tool: `debug/extend_wave_stubs.py`** (append-only). For every stub (a) not already in the
spec, (b) whose `Definitions.Def_<chapter>` target is PUBLISHED on the platform, and (c) whose sol
file exists, it rebuilds the entry the way the generator did — docstring sliced out of the source
chapter at the `state/sketch/sketch_<leaf>.jsonl` offsets, line-linked `source` anchor from the same
record, chapter tags inherited from an already-published node of that chapter — then appends the
slug to `sol_order` after a topological sort of the batch. Only ~2 % of these declarations carry a
docstring, so most get the same generated-title form the live catalogue already uses.

```bash
python3 debug/extend_wave_stubs.py --dry-run [--limit N] [--chapter ChapterX]
python3 debug/extend_wave_stubs.py            # append-only write
```

Result: `pipeline/wave_upload.json` = **112 defs / 1357 thms / 1357 sol slugs**, ORDER **2843**
(backup: `pipeline/wave_upload.json.pre_stubs.bak`). `--status` then reports 1739 done / 1071
pending (454 thm + 617 sol).

**Three un-publishable subsets show up among the new stubs** (each costs one attempt, then parks
`failed`; do not retry them unchanged):
1. **already declared** — the declaration was *embedded* into its def bundle by the §5a repairs
   (`ChapterStoneResolvent.UnboundedSelfAdjoint.resCLM_mem`, `res_shift`), so a separate node is a
duplicate by construction. Drop from the wave; a later `--sync` reuses any node the catalogue holds.
2. **unknown namespace** — the stub opens a namespace its def bundle does not declare
   (`BookProof.EsaClosure`, `BookProof.NavierStokesFlow` in the `FarisLavine_*` / `EsaClosure_*`
   stubs). Same class as §5c: needs the aggregation-bundle treatment before it can submit.
3. **unknown identifier** — the statement cites a helper that lives in the source chapter but in
   neither the def bundle nor a published node (`isSelfAdjoint_galerkinCompression`).

**Session numbers (platform 0.10.3, `--check`):** start **123 published defs / 956 published
problems**; end **123 / 969 published + 7 in flight** (3 PENDING, 4 COMPILING), state **1719 →
1739 done**. Repo sync touched nothing here: the platform-side growth is all new publications.

**REPAIR PASS DONE (2026-09-12, same session) — and what "done" really means.**
The user spotted that the website reports **341 theorems proved** while the pipeline reported far more
"successful" items. Both are right; they count different things. `GET /me` returns
`num_solved_prob: 341` — that is the website's number, i.e. *theorems with a verified proof*. The
state file's "done" is a **plan** metric, and a sample of 40 published nodes returns
`29 Proved / 7 Open / 4 Definition`. Breakdown of the 1 877 `done` records:

| records | meaning |
|---|---|
| 707 sols | skipped — the target theorem was **already Proved upstream** (not our proof) |
| 605 thm nodes | reused — the node was already on the platform |
| 347 thm nodes | **published by us as Open statements** — no proof attached |
| 119 defs | published definition bundles |
| 99 sols | our own submissions the server accepted |

So uploading statements is volume, not proof: only an accepted solution moves `num_solved_prob`.
Journal this in every progress report — "published" and "proved" are different counters, and
`SKETCH_ACCEPTED` (an Open child imported) is a *reduction*, not a proof.

Two repair tools were added and run:

- **`debug/fix_sol_imports_defs.py`** — the Definitions-first solution-import repair. `sol_deps`
  picks the module with the longest dotted prefix, and the generated stubs declare fully dotted
  names while the Definitions bundles declare them bare inside a `namespace` block, so the *stub*
  always won and the tooling imported a (`sorry`) Theorems node instead of the bundle that contains
  the proof. Preferring the Definitions module is the difference between `ACCEPTED` and
  `SKETCH_ACCEPTED`. `--allow-open` additionally accepts a published-but-Open child (reduction), off
  by default. Applied to `GaussCoreQuadBounds` + `SqSumFarisLavine`: **13 files patched**, 32 refs
  still blocked on nodes that are not yet published. Verified: `SqSumFarisLavine_kin_mul_comm` and
  `SqSumFarisLavine_kin_kin_comm` had been failing with `Unknown identifier` in ~1 s and now submit
  and compile; `kin_kin_comm` also exercises the stale-verdict resubmit guard.
- **`debug/repair_stubs.py`** — statement-level repair for the two mechanical classes:
  *unknown namespace* → add the `Definitions.Def_<chapter>` import that declares the opened
  namespace (a published one; nested `namespace` blocks must be composed, or the analysis invents
  bogus misses), and *already declared* → **drop the slug** from the wave spec (and its `sol_order`
  entry): the declaration was embedded into its def bundle by the §5a repairs, so a separate node is
  a duplicate by construction. Result: **109 stubs rewritten**, **47 duplicates dropped** (spec
  1357 → 1310 thms). Verified: `FarisLavine_conj_mul_ofReal` (was `unknown namespace
  BookProof.NavierStokesFlow`) → **DONE**, and `FarisLavine_mulComparison_surjective` /
  `HashimotoShiftInvert_IsShiftInvertC_mem` re-submitted off the repaired statements and accepted.
  Stubs whose node is already published are never rewritten.
- **Still open:** the *unknown identifier* class (the statement cites a helper that lives in the
  source chapter but in no published module, e.g. `QgHermiteFriedrichs_cpoly_*`,
  `GaussCoreQuadBounds_coreD_sq_mul`). Fix by publishing the helper's own node first (walk ORDER,
  which reaches `QgHermiteFriedrichs` late), then re-run the Definitions-first tool with
  `--allow-open` if a reduction is acceptable.

**Next steps (in priority order).**
1. **Keep calling bounded chunks** — this is now a volume grind, not a bug hunt: `--kind thm`
   resolves ~15-23 nodes per 100 s chunk at `--parallel 20`. Thms are cheap; sol proofs are slow
   and only ever resolve on a later chunk, so alternate thm chunks with `--kind sol` chunks.
2. **Repair the three structural classes above** before their 5th attempt parks them: `failed` is
   terminal in the selector, so a parked item needs `debug/reopen_failed.py --only SUBSTR` (which
   is also why the runner wants a `--retry-failed` flag). The "unknown namespace" case is the §5c
   aggregation-bundle recipe; "already declared" should just be dropped from the wave spec.
3. **Re-run `debug/fix_sol_imports.py` once the `QgHermiteFriedrichs_*` / `HermiteProductCore_*`
   nodes are published** (they are the `status=absent` blockers of §1b). Importing a node that is
   still `Open` is not an error for a *solution* — the server answers `SKETCH_ACCEPTED`, a terminal
   success that resolves the item — so the tool's Proved-only gate should be relaxed (or a
   `--allow-open` flag added) for the 34 sols in `GaussCoreQuadBounds` / `SqSumFarisLavine`.



### 1e. CORRECTION to §1c — the daemon DOES work here, and the solution-side repairs

**§1c's "no persistent background process" is wrong for a detached run.** A *foreground*
bounded chunk dies with the tool call, but `bash start_upload.sh start` (which does
`setsid nohup bash -c "while true; do …; done" … & disown`) **survives across calls and 502s**,
verified over ~10 minutes. A plain `nohup … &` survives ordinary calls but is killed by the
transport-error (502) path, so use the wrapper, not a hand-rolled `nohup`.

**The wrapper was running the pipeline in *sequential* mode.** `PIPELINE` had no `--parallel`, so the
daemon resolved ~1-4 items/60 s instead of the measured 10-50. It now passes
`--parallel 50 --job-timeout 60` (override with `PROVE2ME_PARALLEL` / `PROVE2ME_JOB_TIMEOUT`).

**Log destinations differ.** The wrapper redirects the pipeline's stdout to `state/upload.log`;
`state/pipeline.log` is only written when *you* redirect a foreground run into it. Read progress from
`state/upload.log` (and from `state/pipeline.json`) while the daemon runs. Beware: `log()` writes to
stdout, so a foreground run redirected with `>> state/pipeline.log` produces every line twice.

**PUBLISHED module graph ≠ local module graph.** A solution that relied on a *transitive* import for a
namespace it opens was rejected with `unknown namespace BookProof.HermiteGalerkin` even though its local
import (`Def_ChapterBandEnclosure`) does import the declaring bundle (`Def_ChapterHermiteGalerkinFriedrichs`).
**Rule: every namespace a file `open`s must be declared by a module the file imports *directly*.**
1122 solution files were repaired on that rule.

**Solution-side repair tools added (the proof files had the same generator gaps as the stubs):**

| tool | does |
|---|---|
| `debug/fix_sol_ns_imports.py` | add the direct `Definitions.Def_*` import for every opened-but-undeclared namespace; `--drop` removes opens no bundle can declare (KatoRellich, DirectSumEsa, … — a hard error otherwise) |
| `debug/fix_sol_def_imports.py` | add import + `open` for identifiers the recorded CE names (`harmCore`, `cpoly_sum`, `gaussInt_coreD`, …) |
| `debug/restore_opens.py` | **correct** Lean namespace scanner (`section`/`end` tracked in the same stack as `namespace`) + restores valid opens a buggy drop pass removed |
| `debug/drop_embedded_dups.py` | drop wave slugs whose declaration is already embedded in an imported def bundle |
| `debug/def_jobs.py` | list definition publish jobs by status (`theorem_name` = module name) |

**Post-mortem on a bug I introduced and fixed.** The first `fix_sol_ns_imports.py --drop` used an inline
scanner that pushed only `namespace` blocks but popped on **every** `end`, so a `section … end` closed the
enclosing namespace and namespaces declared after the first section looked undeclared. It dropped 13
*valid* opens (e.g. `BookProof.YangMillsHermite.RealCoeff`, which `Def_ChapterYangMillsHermite` does
declare); `debug/restore_opens.py` re-adds them from `git show HEAD:<file>`. The same class of scanner bug
made `drop_embedded_dups.py` initially find nothing.

**Facts worth keeping.** (a) Definition publish jobs are *retried*: 45 FAILED def jobs are all superseded
by a later PUBLISHED job — only 3 modules (the `TestDef*` probes) have no published job at all, so a
FAILED def job is NOT evidence the bundle is missing. (b) The 6
`ChapterStoneResolvent.UnboundedSelfAdjoint_*` nodes are already out of the wave spec (state orphans); the
server rejects them with `has already been declared` because the declaration is embedded in
`Def_ChapterStoneResolvent` — they must never be re-added. (c) The daemon sits silent for minutes at a
time with 50 solutions in flight: solutions take >150 s each to verify and the server serialises its
compile queue, so `state/upload.log` going quiet is normal, not a hang.

### 1d. Session 3 (2026-09-12 evening) — three more generator-repair tools, and the counting rule

**Read the backlog from `--status`, never from the state file.** `plan_progress` counts an
in-plan item with **no state record at all** as pending, so the numbers differ by design:
the state file said `164 pending`, while `--status` said `704 pending` — the ~540 difference is
items the runner never reached (all sols/thms skipped by the preflight while the def layer was
still incomplete). With the def layer now **112/112 done** those are reachable, so a plain
unfiltered `--kind thm` / `--kind sol` chunk picks them up in ORDER. `state/pipeline.json`'s
`pending`/`failed` counts are record-level bookkeeping, not the plan frontier.

**Three generator defects repaired (all statement-level, all mechanical).** Each was a distinct
shape of the same root cause — the stub copies only what it thinks it needs from the source
chapter, and anything the source resolved *through its enclosing namespace context* is lost:

1. **Path-relative `open`s → `unexpected ... unknown namespace X`.**
   `BookProof/ChapterNavierStokesThreeComponent.lean:78` writes
   `open LpNat FarisLavine IkebeKato ShiftHamiltonian SignedShift` while sitting inside
   `namespace BookProof.NavierStokesFlow` → `namespace ThreeComponent`. The stub lifts that line
to file root, where the bare names do not resolve. **`debug/fix_bare_opens.py`** resolves each
   bare token against the namespaces actually declared by the stub's transitive
   `Definitions.Def_*` imports (nested `namespace` blocks composed), and rewrites only tokens that
   are neither root-declared nor ambiguous. 101 files patched (`FarisLavine` → `BookProof.FarisLavine`,
   `LpNat` → `BookProof.NavierStokesFlow.LpNat`, …). *An earlier revision of this tool merged
   adjacent `open` lines because its regex ended in `\s*$`; it now normalizes one command per line
   and is idempotent.*
2. **`open scoped … lp` missing → `unexpected token '²'`.** `ℓ²(ℕ, ℂ)` is notation **only inside the
   `lp` scope**: the def bundle carries `open scoped InnerProductSpace ENNReal lp`, the stub copies
   only `… ENNReal`. **`debug/fix_scoped_opens.py`** adds `lp` to any stub using `ℓ²`. Exactly 7
   files. (A union-of-all-transitive-scopes rule was measured to touch 1312 stubs for no reason —
   the rule is deliberately narrow to the one scope that actually breaks a statement.)
3. **Statement cites a declaration from *another* def bundle → `Unknown identifier X`.**
   **`debug/fix_stub_def_imports.py`** indexes every top-level declaration in every `Definitions/`
   bundle (`def`/`theorem`/`lemma`/`abbrev`/`structure`/`class`/`instance`), and for each identifier
   named in the item's recorded error adds `import Definitions.Def_<bundle>` plus `open <innermost
   namespace at the declaration>`. 13 files. Identifiers declared in **no** def bundle are reported
   `BLOCKED` (7 of them — see the residual list below). `debug/repair_stubs.py` does a
   statement-static superset of this (40 files) and remains the primary pass; run both.

**Residual `failed` classes (statement-level, each needs its own node published first).**
`isSelfAdjoint_galerkinCompression`, `sqSumOp`, `sectorRestrict_isSymmetric`, `harmCore`,
`single_mem_fockCore`, `polyGaussCore_le_diffMaxDom` are `def`s that live only in the source
chapter (`BookProof/Chapter*.lean`) and in no published module, so the stub's statement cannot
compile. Publishing them means adding **definitions** (`debug/add_wave_def.py`), not theorem
nodes. Two further classes are not mechanical and are left alone: `Invalid field `mem`` /
`Invalid constant X.mem` (the statement uses a `.mem`/field access that does not exist on the
inferred type) and 6 `ChapterStoneResolvent.UnboundedSelfAdjoint_*` nodes that are **duplicates**
— their declarations were embedded into `Def_ChapterStoneResolvent` by the §5a repairs, so the
standalone node can never compile.

**Why the repaired statements were worth it:** the `Unknown identifier` sols in
`GaussCoreQuadBounds` / `SqSumFarisLavine` (the chapters §1b left blocked) now resolve — those
families moved from instant CE failures to `DONE` at ~10 items/chunk. The remaining heavy sol
classes are `SqSumFarisLavine_*` and `NavierStokesFlow_Lagrangian*`, blocked on helper **nodes
that are in the wave spec but not yet published** (`QgHermiteFriedrichs_inner_pgLp_pgLp`,
`StoneBridge_exists_stone_flow_of_esa`, `HashimotoShiftInvert_IsShiftInvertC_opNorm_le`,
`HermiteGalerkin_galerkinCompression_tendsto`, `QgHermiteFriedrichs_hamCore_symmetricOn`, …).
Those are ordered work, not a defect: publish the thm node (even `Open`) and the importing sol
resolves as `SKETCH_ACCEPTED`.

**Session 3 numbers** (platform 0.10.3 / skill 0.10.3, `leonardopedro`):

| metric | session start | session end |
|---|---|---|
| `num_solved_prob` (the website's "theorems proved") | 352 | **394** |
| published problems | 1120 | **1289** (+18 pending, 3 compiling) |
| in-plan thms done / pending | 1058 / 214 | **1206 / 70** |
| in-plan sols done / pending | 821 / 490 | **889 / 422** |
| state records done / pending / failed | 2121 / 164 / 20 | **2330 / 139 / 23** |

Measured throughput: **~10–38 items resolved per ~60 s chunk** at `--parallel 45–60` (thm chunks
resolve faster than sol chunks; sols take >150 s per proof and mostly drain on the *next* call).

**Tooling added this session:** `debug/fix_bare_opens.py`, `debug/fix_scoped_opens.py`,
`debug/fix_stub_def_imports.py`, `debug/platform_stats.py` (`/me` + state breakdown in one shot).

**Next steps.**
1. Keep calling bounded chunks — alternate `--kind thm` (fast, unblocks sols) with `--kind sol`.
   The thm frontier is nearly clear (~70), the sol frontier is the long grind (~422).
2. Publish the blocked helper `def`s listed above via `debug/add_wave_def.py`, then re-run
   `debug/repair_stubs.py` and `debug/fix_stub_def_imports.py` and reopen with
   `debug/reopen_failed.py --yes --only SUBSTR`.
3. Drop the 6 `ChapterStoneResolvent.UnboundedSelfAdjoint_*` duplicates from `wave_upload.json`
   (they can never compile) so the plan stops counting them as failed.

- **Local state note**: 38 sols were found carrying a live `submission_id` already `ACCEPTED` on the
  platform, left behind by chunks killed before their drain. The re-poll guard collects them on the
  next `--kind sol` run; no manual state surgery is needed and none should be attempted.

**§1b — the "failed" solutions were not proof failures (verified 2026-09-12).** Every one of the 24
sols in `ChapterSirkEndToEnd` / `ChapterSirkPerSystem` / `YangMillsHermite` that this runbook recorded
as a CE failure targets a node the platform already reports **`Proved`** (resolved by `theorem_id`, not
by name). At catalogue scale **374 of 577** locally-pending sols were already `Proved` upstream — they
looked pending only because `--sync` reconciled defs/thms from `publish-jobs` but never reconciled
*solutions* (a solution has no publish job). `sync_state` now resolves every pending `sol:` through its
`theorem_id` and marks it done; one `--sync` moved the state **1180 → 1558 done / 318 pending**, and
all three chapters are now `0 pending` (14 + 7 + 47 sols).

- **GENERATOR BUG — a solution never imports the other chapters its proof cites.** `build_sol` emits
  `import Theorems.Thm_<own chapter>_<dep>` for siblings *inside* the target chapter, but a generated
  solution imports only `Definitions.Def_<own chapter>` (definition-only bundles). Any lemma inherited
  from a chapter the source module imports is therefore an `Unknown identifier`, and the compiler stops
  at the first one, so it surfaced one round trip at a time. **273 of 1440 local solutions** carry this
  defect — that is what the CE messages actually were (`numRange_compress_subset`,
  `sirk_error_tendsto_zero`, `sirk_error_decay_exponential`, `diagKR_hashimoto_selects`,
  `nsDiffH_shiftInvert_selects`).
  Tooling: `debug/sol_deps.py` resolves the whole missing set statically — comments stripped, and gated
  on the file **already opening** the declaring namespace (the ambiguity-safe rule), with pattern-only
  names such as a match arm `| add p q =>` excluded. `debug/fix_sol_imports.py --chapter X [--dry-run]`
  writes them, refusing any import whose node is not `Proved` ("imported platform theorems must be
  Proved at submission time"). Applied to the three chapters: 12 files patched; 20 references remain
  blocked on 15 dependency nodes **absent from the platform** (they are in the tree, but never in the
  wave spec, so never published — `--only`/the wave extender is the route).
- **The cross-chapter import form is confirmed to work**: `{ChapterSirkEndToEnd}_crouzeix_domain_uniform`
  (which needs `ChapterH9.numRange_subset_closedBall` from a different module) was submitted and
  returned **ACCEPTED** — the same `import Theorems.Thm_*` mechanism the QgHermite def fix relied on.
- **BUG — a stale verdict could be reported as a failure of the current proof.** `do_wave_sol`
  re-polled a recorded `submission_id` without checking whether the solution file had changed since, so
  a chunk read the verdict *of the pre-fix revision* (`line 33: Unknown identifier
  numRange_subset_closedBall`, terminal in **1 s** versus ~5.5 min for a real compile) and counted it
  against the fixed file. Each submission now records `submission_src` (sha1 of the file); when the file
  no longer matches, the obsolete id is dropped and the current revision resubmitted instead of burning
  one of the 5 attempts on a dead verdict.

- **BUG — the statement splitter's identifier boundary rejected Lean-primed names.** `do_wave_thm`
  locates the declaration with `^theorem\s+<name>\b`. A trailing `\b` cannot express "not a prefix of
  a longer identifier" when the name ends in a non-word character: for `…commutator_sum_le'`, the `'`
  followed by a space has **no word boundary**, so the regex never matched and the item reported
  `cannot split formal_statement` — one of the 5 attempts burned per visit until `failed`. Replaced
  with a negative lookahead `(?![A-Za-z0-9_'.!?])`, which also keeps the prefix guard (the unprimed
  name no longer matches the primed declaration).
- **BUG — the wave spec's dotted `name` is a heuristic, and the file is authoritative.**
  `wave_upload.json` is assembled with a `_` → `.` rewrite, which is right for chapters that open a
  namespace per component (`…LinearIsometryEquiv.isNote4Unitary`) but wrong for an identifier that
  keeps its underscores: the spec held `…FarisLavineLift.norm.inner.commutator.sum.le'`. A wrong name
  is not cosmetic — the splitter looks for it verbatim and never finds it. `reconcile_thm_names()` now
  runs at import: when the spec's name is not a declaration in the file, a stub declaring exactly one
  top-level `theorem` adopts that declaration (multi-declaration files fall back to comparing the
  names with `.`/`_` dropped). It reports its repairs in `REPAIRED_THM_NAMES` instead of silently
  patching the payload. Exactly 1 of 890 thms was affected — the other 2 primed names
  (`FockCanonical_coe_sum_apply'`, `FockManyMode_modeShift_shift_ne'`) are among the unsubmittable
  items below and have no file to correct from.
- **Platform rule re-confirmed (was already §6.1): `theorem_name` rejects a trailing prime.**
  `submit-problem` answered `theorem_name must be a valid Lean identifier (identifier segments
  separated by '.')` for the repaired primed name. The node is published under
  `…norm_inner_commutator_sum_le_alt` — a deliberately *different* name from the documented `_prime`
  convention, chosen because it was already published by the time the rule was noticed and re-publishing
  under `_prime` would add a duplicate statement node to the catalogue. **Use `_prime` for any future
  primed declaration.**
- **GAP — `failed` items are permanently unreopenable.** The selector skips `done` *and* `failed`
  (lines ~1001, ~1050), and nothing resets them, so a defect at the submit boundary strands every item
  it broke — exactly what happened to the item above. `debug/reopen_failed.py [--yes] [--only SUBSTR]`
  reopens them (attempts → 0, dead `job_id`/`submission_id` dropped, backup `state/pipeline.json.bak.reopen`).
  The runner should grow a `--retry-failed` flag; `str_replace` cannot reach past ~line 1300 of
  `upload_pipeline.py`, which is why this lives in `debug/` for now.
- **65 items are unsubmittable: 60 thm stubs + 5 sols that were never generated** (47 `NavierStokesFlow*`,
  13 `ChapterContinuityUnitaryInfinite`, 2 each `ChapterH6`/`ChapterH9`, 1 `ChapterH8`). The source
  chapters **are** in the checkout (`BookProof/ChapterNavierStokesFockManyMode.lean:181` really does
  declare `fockH_apply`) and `state/sketch/sketch_<leaf>.jsonl` carries the declaration spans, but
  `scripts/wave_generate.py` needs `decl_graph.jsonl` (hardcoded `/home/leo/Projects/timepiece/…`,
  absent here) to attach the dotted `uname` that `build_thm` writes, so regenerating them needs either
  that graph or reconstructed nodes from the sketch files. **Do not re-run the generator unguarded:**
  it overwrites `Theorems/`+`Solutions/` wholesale and would revert the cross-chapter import fixes.

**Status (2026-09-10) — historical, counts superseded by §1a:**

- Compile gate: **70 / 70 bundles OK, 0 FAIL** (`state/compile_check.log`) — the
  wave-1 def gate. Wave-2/3 added ~15 more gated def bundles (§1b).
- `pipeline/wave_upload.json` now **91 defs / 440 thms / 440 sols** across waves 1–3
  (wave-1: 70 defs + 82 deferred thms; wave-2: +SirkRestart/SirkRitzSpectrum/
  SirkTruncation + ContinuityUnitaryInfinite/H1/H4/H6/H8/H9/SirkSpectralGeometry
  (+85); wave-2.5: +SirkGramWhitening/GramCutoff/TrotterKato/MultiShift (+77);
  wave-3: +SirkTrotterKatoGalerkin/GapTable/CertifiedGap/RitzMinMax/RitzPerturbation/
  SignedShift (+127)). Extender scripts: `debug/extend_wave.py` (wave-1) and
  `debug/extend_wave_next.py` (waves 2–3).
- **Upload RUNNING** via the resilient wrapper (`./start_upload.sh status`;
  log `state/pipeline.log`). Progress (2026-09-10 ~11:30): **defs 99/99 done,
  thms ~379/428 done, sols ~309/407 done**, a small expected `failed` tail (the
  documented proof-gap sols + a few pre-fix thm caps). New nodes confirmed on the
  platform via `GET /publish-jobs` (RitzMinMax/SignedShift thm nodes PUBLISHED).
  Per-item job polls can idle up to `JOB_TIMEOUT=900s` on big bundles — NORMAL.
- **ESA scope decision (binding, human):** standalone `*Esa` chapters are
  EXCLUDED from waves — only the Friedrichs extension of `N` lifts to the outer
  Fock space, not the one-particle ESA proofs; publish ESA content only via
  Faris–Lavine (§8).
- **Upload RUNNING since 2026-09-10 00:15** via the resilient wrapper
  (`./start_upload.sh status`; log `state/pipeline.log`). Progress snapshot at the
  time of writing: **~50/54 defs done, 0 failed**, then 151 thms + 151 sols. Per-item
  job polls can idle up to `JOB_TIMEOUT=900s` on big bundles (StoneUnitary etc.) —
  that is NORMAL, not a hang.
- **`topological_def_order` BUG FIXED (commit `d6b8c52`)**: the function returned
  `list(reversed(order))`, which made `WAVE_DEF_ORDER` **dependents-first**
  (287 ordering violations with the 70-def wave — e.g. SirkPerSystem would publish
  before H4/FarisLavineCore and its platform compile gate would fail). Removed the
  reversal; order is now deps-first (verified: 0 violations; SirkPerSystem is last,
  pos 78). **Do not re-add the `reversed()`** when editing this function.
- Git: `f1905e8` (gate green 70/70 + wave spec + debug tooling + legacy) and
  `d6b8c52` (uploader topo-order fix) are **pushed to the fork only** (`leonardopedro`).
  Uncommitted by design: `state/pipeline.json` (append-only runtime state), the 231
  Solutions + 237 Theorems future-wave stubs.
- The 4 deferred chapters' thm/sol stubs ALREADY exist in `Theorems/`+`Solutions/`
  (14 SirkEndToEnd + 14 SirkWhitening + 7 SirkPerSystem + 47 YangMillsHermite) and
  import `Definitions.Def_<chapter>` — they compile only after the def bundle is
  published.
- Deferred Sol gate: **67 / 82 build locally**. The remaining 15 sols depend on
  upstream **node** theorems (not in this wave's thm/sol) via the generator's
  cross-chapter dependency gap (§8); their thm stubs still publish as Open and
  the sols are a follow-up (add the upstream helper thm/sol nodes, or embed the
  helpers in the upstream def bundles). 6 helper Thm stubs were created for the
  follow-up: `Thm_BookProof_ChapterH6_sirk_error_decay_exponential`,
  `Thm_BookProof_ChapterH6_sirk_error_tendsto_zero`,
  `Thm_BookProof_ChapterH8_compress_rational_transfer`,
  `Thm_BookProof_ChapterH9_numRange_compress_subset`,
  `Thm_BookProof_ChapterH9_numRange_subset_closedBall`,
  `Thm_BookProof_NavierStokesFlow_NSHashimoto_ns_hashimoto_selects`.

**Execution order:**

1. ~~Fix the 29 failing def bundles (§5 attack order)~~ **DONE — gate 70/70.**
2. ~~Mark the 57 SirkFinitePrecision orphans + 5 stale def-entries done in
   `state/pipeline.json`~~ **DONE** (their platform nodes are already Proved; def id
   `9d97fdc1-ddf5-49ea-900f-85f1e8af95f1`). Append-only — never delete state.
3. ~~Extend `pipeline/wave_upload.json`~~ **DONE (79 defs / 151 thms / 151 sols).**
4. Local gate green, upload restarted → **IN PROGRESS** — monitor
   `./start_upload.sh status` to completion; watch for per-item `failed` (expect the
   15 deferred sols to fail gracefully — thm stubs stay Open).
5. ~~Update §1 counts; commit; push to the fork only~~ **DONE (`f1905e8`, `d6b8c52`).**
   Re-commit when the upload completes (§1 counts + any failure follow-ups).

### 5a. Remaining failure roots (attack order)

**RESOLVED (2026-09-10): all 21 gate failures fixed; gate green 70/70.**

Roots fixed (the cross-chapter helper theorems were embedded as real proofs in
their defining upstream def bundles):

1. **HermiteProductCore/Basis** — embedded `integral_prod_coord`, `norm_sq_eq_sum`,
   `gaussWD_eq_sq`, `gaussWD_eq_prod`, `gwFun_eq`, `integrable_gwFun`,
   `gaussInt_add/smul/sum`, `gaussMoment_succ`, `gaussInt_monomial`,
   `gaussInt_pderiv`, `derivative_hermiteZ`, `hermiteZ_X_mul`, `hermiteCx_*`,
   `hermiteFactor_*`, `hermiteMv_*`, `mul_X_mem_span_hermiteMv`, `span_hermiteMv`,
   `polyGaussCore_eq_hermiteSpan`, `span_range_coreBasis`, `hermiteMvLp_mem_core`.
2. **NavierStokesIkebeKato** — embedded `memLpTwo_of_finite_support`,
   `diagMax_coe`, `finiteModes_le_maxDom`; **NavierStokesEsa** — embedded
   `lpFiniteModes_dense`, `finiteModes_dense`, `shiftOp_mem_finiteModes`,
   `velocityOp_mem_finiteModes`; **ContinuityUnitaryInfinite** — `shiftOp_apply`;
   **NavierStokesDeficiency** — `inner_eq_sum_range`, `jacobi_wronskian`,
   `jacobiOp_coe`, `jacobiOp_symmetric`, `diagOp_coe`.
3. **NavierStokesCanonicalVector** — embedded `mkCore_coe`.
4. **YangMillsFriedrichs** — +import FarisLavineCore +`open BookProof.FarisLavine`;
   embedded `weylOp_apply`, `inner_sq_eq_normSq`, `weylOpDom_symmetricOn`,
   `weylOpDom_quadForm`, `weylOpDom_quadForm_nonneg`.
5. **FriedrichsExtension** — regenerated def bundle (defs only), removed
   HashimotoShiftInvert/HermiteGalerkin/YangMillsFriedrichs opens (source-only),
   fixed `incl` `simpa`→`show`+`rw [one_mul]`; **ComplexShiftCore** — removed the
   inlined `SymmetricOn` (now `open BookProof.FarisLavine`), fixed
   EsaClosureCore's qualified references.
6. **Stone family** (Group/Evolution/Unitary/Measurable/Resolvent/Converse/
   Theorem/Bridge) — regenerated Group/Evolution/Unitary def bundles and embedded
   the full Yosida/approxU/stoneU chains (`yosida_*`, `jn_*`, `res_sub`,
   `approxU_*`, `norm_stoneU_*`, `tendsto_stoneU_*`, `stoneU_*`,
   `continuous_stoneU_apply`, `measurable_inner_stoneU`, von Neumann's
   `tendsto_apply_zero`/`continuous_apply` chain in StoneMeasurable,
   `apply_apply`, StoneResolvent resolvent lemmas); StoneBridge +imports
   EsaClosureCore/UnitaryTransport/StoneResolvent + opens; StoneConverse
   `convert` fix (`· rfl · norm_num`), `dense_avgSpan` via
   `dense_iff_topologicalClosure_eq_top`.
7. **NavierStokesThreeComponent** — +imports Deficiency/IkebeKato/
   ShiftHamiltonian/FarisLavineCore; **SignedShift** regenerated (was empty);
   **NavierStokesHashimoto/LagrangianKatoRellich/DifferentialL2/HermiteRelativeBound/
   DiffHashimoto/StarobinskyPotential** — added the missing upstream Def imports +
   matching opens.
8. **HashimotoComplexShifts:216** — `map_add'`/`map_smul'` Pi.add pattern fixed
   (`lp.coeFn_add` + `dsimp [PreLp]` + `rw [mul_add]`); same fix in
   **HashimotoShiftInvert** `diagLin`.
9. **SirkPerSystem** — built the §5c aggregation bundle (imports + empty
   `BookProof.ChapterSirkPerSystem` namespace) so its 7 thm stubs compile.
10. **YangMillsHermite** — empty sub-namespaces `RealCoeff/PolySym/PolyAdj`
    declared so the dot-named thm stubs' `open` resolves; ambiguity from
    ComplexShiftCore's inlined `SymmetricOn` removed.

**Still open (deferred Sols only, non-blocking):** the 15 deferred sol files
whose proofs call upstream *node* theorems (`weylOp_*`, `friedrichs_extension_*`,
`gaussInt_*`, `numRange_*`, `compress_rational_transfer`, `sirk_error_*`,
`*_hashimoto_selects`, `*_shiftInvert_selects`, `qgR2_stone_flow`,
`lagrangian_shiftInvert_selects`, `nsDiffH_shiftInvert_selects`,
`diagKR_hashimoto_selects`, `ns_hashimoto_selects`, `rangeProj_apply`,
`mulOp_apply`). The generator does not import cross-chapter node deps into Sol
files (§8). Their thm stubs publish as Open; embed the helpers in the upstream
def bundles (pattern above) or publish the helper thm/sol nodes in a follow-up
wave.

### 5b. Already fixed this wave (do not redo)

| Chapter | Fix |
|---|---|
| FarisLavineCore | added missing `import Mathlib` |
| StoneResolvent | +import Def_ChapterUnitaryTransport + `open BookProof.ChapterUnitaryTransport`; `Dense.eq_zero_of_inner_left` explicit-𝕜 call `(𝕜 := ℂ)` + lambda `fun v hv => key ⟨v, hv⟩`; embedded `res_shift`, `op_res`, `resCLM_apply`, `resCLM_mem`, `norm_resCLM_apply_le`, `res_op`, `inner_res`, `res_comm` |
| NavierStokesEsa | +imports Def_ChapterContinuityUnitaryInfinite + Def_ChapterNavierStokesFlow + matching opens (L2Z, NSTruncation, nsFlowUnitary) |
| HermiteFunctions | 6 v4.33-drift repairs (see §6.3 for the patterns) |
| HashimotoComplexShifts | +`open scoped lp` (ℓ² notation); `map_add'`/`map_smul'` Pi.add fix |
| SirkEndToEnd/SirkWhitening/YangMillsHermite | regenerated via `python3 scripts/wave_generate.py`; YangMillsHermite def bundle declares the empty `RealCoeff/PolySym/PolyAdj` sub-namespaces |
| StoneMeasurable | embedded the von Neumann chain (`tendsto_apply_zero`, `continuous_apply`, `dense_avgSpan`, `avgSpan_orthogonal_eq_bot`, `ae_inner_eq_zero`, …) + `apply_apply`, `surjective`, `inner_map_map` |
| StoneGroup / StoneEvolution / StoneUnitary | regenerated + embedded the full Yosida/approxU/stoneU chains (see §5a.6) |
| ComplexShiftCore | removed the inlined `SymmetricOn` (now `open BookProof.FarisLavine`); EsaClosureCore qualified refs fixed |
| NavierStokesFullEsa / NavierStokesLagrangianEsa | regenerated; `restrictCLM` simpa→`change` fixes |
| NavierStokesHashimoto | regenerated (defs only) + upstream imports for the opened namespaces |
| NavierStokesLagrangianKatoRellich | regenerated + imports; dropped the `BookProof.KatoRellich`/`HermiteGalerkin` opens (source-only namespaces) |
| NavierStokesDiffHashimoto / HermiteRelativeBound / StarobinskyPotential / NavierStokesDifferentialL2 | added the missing upstream Def imports + matching opens |
| SirkPerSystem | aggregation bundle built (imports + empty namespace), see §5c |

### 5c. SirkPerSystem — aggregation bundle (DONE 2026-09-10)

It has NO def material (7/7 decls are node theorems) but its thm statements use
names from ~18 upstream chapters.  `Definitions/Def_ChapterSirkPerSystem.lean`
is the hand-written aggregation bundle: no defs of its own, just `import Mathlib`
+ `import Definitions.Def_*` + an empty `namespace BookProof.ChapterSirkPerSystem`
(so the dot-named thm stubs' `open` resolves), covering the opens the 7 thm
stubs use (`ChapterH4, H9, SirkSpectralGeometry, HashimotoShiftInvert,
FarisLavine, EsaClosure, YangMillsFriedrichs, YangMillsHermite, HermiteProductCore,
Starobinsky, NSFlow.LpNat/.ThreeComponent/.IkebeKato/.NSHashimoto/.DiffHashimoto/
.DifferentialL2/.LagrangianEsa/.LagrangianKatoRellich`).

### 5d. The repair method that works (proven on StoneResolvent/HermiteFunctions)

```
lake env lean Definitions/Def_<X>.lean   # read the FIRST error
grep -rn "<missing name>" Definitions/   # find its defining chapter
# → add  import Definitions.Def_<that>  +  open <its namespace>  after the last import
```

For type-mismatch/drift errors use the convert/trace recipe (§6.3). Iterate to exit 0,
then re-run the full gate. **Do NOT bulk-sync imports by script** — static name
matching produces ambiguity clashes (many bundles inline their upstream decls) and
wrong opens. The compiler is the only reliable oracle; three script attempts
(`debug/sync_upstream_imports.py`, `sync_imports_v2.py`, `v3.py`) all failed and are
kept as reference only.

---

## 2. Platform model (what compiles where)

The platform compiles each **def bundle** (`Definitions/Def_ChapterX.lean`) with ONLY
`import Mathlib` + `Definitions.Def_*` modules **already published**. Consequences:

1. `import Definitions.Def_Y` fails on the platform if Y was never published — even
   though it compiles locally. This is why upstream defs must be published first.
2. `import BookProof.*` in a def bundle is **platform-fatal**. `open BookProof.X` is
   harmless ONLY because the bundle itself declares those namespaces inline — if the
   referenced decls are not in the bundle, it breaks.
3. Thm stubs and Sol files import `Definitions.Def_<chapter>` — everything they
   mention must be defined in that one def bundle (or its published imports).
4. `:= by sorry` is tolerated ONLY in a Thm stub's `formal_statement`. Def bundles and
   Sol files must be sorry-free.
5. `import Definitions.Def_X` for an ALREADY-published X is the platform's designed
   dependency mechanism — use it, never inline whole chapters (inlining was tried and
   abandoned; see LEGACY §12.9).

---

## 3. Uploader & resilient launch (`pipeline/upload_pipeline.py`, `start_upload.sh`)

- Ordered plan = `LEGACY_ORDER` (17-item pilot) + `WAVE_ORDER` from
  `pipeline/wave_upload.json`: `def:<chapter>` first, then `thm:<slug>` / `sol:<slug>`
  in topological order. Def publish order is auto-computed from
  `import Definitions.Def_*` lines. **`topological_def_order` was fixed (commit
  `d6b8c52`)**: it previously returned `list(reversed(order))` (dependents-first —
  platform compile gate would fail on every dependent bundle). Order is now
  deps-first; keep it that way.
- State: `state/pipeline.json`, saved atomically after every item; **append-only** —
  never reset history, keep dedupe/reuse records.
- Exit codes: **1 while work remains** (wrapper restarts), **0 when done**. After
  adding new items to the wave, re-run `./start_upload.sh start`.
- Job-id re-poll: the server `job_id` is recorded in state BEFORE polling; retries
  re-poll instead of resubmitting (the server does NOT dedupe by name).
- Dedupe / coverage / reduction (binding, automatic per item):
  (a) search the catalog before submitting; reuse existing nodes on exact or
  whitespace-normalized match; `already exists` rejections self-heal.
  (b) existing **Proved** theorems with the same normalized conclusion ⇒ candidate is
  a corollary → SKIPPED (`covered_by` recorded).
  (c) reduction-first for agents: if existing Proved theorems imply the target, prefer
  a 5-line import-based sketch (`SKETCH_ACCEPTED`) over a 50-line transplanted proof.
- Attempts cap 5 per item → permanent `failed`. Solutions require their theorem
  published (theorem_id in state).
- Source of truth for platform contents: `GET /api/v1/publish-jobs?kind=…` (owner's
  jobs) and `GET /api/v1/theorems?tags=timepiece` (public catalog). NOTE: `q=` search
  MISSES many def nodes — verify by direct `GET /theorems/{id}`; state def_ids are
  authoritative.

**Resilient launch** (survives logout, crash-looped):

```bash
cd /home/leo/prove2me_workspace
./start_upload.sh start     # setsid + nohup + while-loop restart (rc==0 → break)
./start_upload.sh status    # running? + log tail
./start_upload.sh stop | restart
# PID /tmp/upload_pipeline.pid ; logs state/upload.log + state/pipeline.log
```

State is saved per item, so restarts resume exactly. systemd alternative (as leo):
`sudo systemctl start|stop|status upload-timepiece` (Restart=on-failure, boots at
multi-user.target; logs `state/pipeline.log` + `state/service.log`).

---

## 4. Current platform & workspace state (verified 2026-09-09 late; superseded for the wave by §1 Status)

**Published on the platform:**

- **17 def nodes**: timepiece_corrector, MassGap, BRSTNilpotent, GhostField,
  NavierStokes, YangMillsFieldStrength, GaugeFixing, BaryonAsymmetry,
  MajoranaClifford, MajoranaProp61, MajoranaProp76, ParityMajoranaQuant,
  SirkGroupTransfer, YangMillsBianchi, YangMillsSU3, SirkDiffusiveDecay,
  SirkFinitePrecision.
- **147 wave items done** (9 defs + 69 thms + 69 sols from the published wave);
  the §1 wave adds 70 defs + 82 thm/sol slugs on top.
- All SirkFinitePrecision thm nodes are **Proved** on the platform → the 57 pending
  `BookProof_SirkFinitePrecision_*` state entries are true ORPHANS to mark done
  (marked done 2026-09-10).
- **Uploader RUNNING** since 2026-09-10 00:15 (§1 Status for progress).

**Workspace:**

- `pipeline/wave_upload.json` — current wave spec; **EXTENDED 2026-09-10 to 79 defs /
  151 thms / 151 sols** (see §1 Status). Pre-extension backup:
  `pipeline/wave_upload.json.full.bak`.
- `state/pipeline.json` — append-only upload state, updated live by the running
  uploader (contains the done-marked orphans + 74 pending deferred items).
- `debug/compile_check.sh [LIST]` — the compile gate (per-module
  `lake build Definitions.Def_<X>`; NOT `lake build Definitions`, which drags in the
  `BookProof` lib and fails on 2 unrelated source files). Writes
  `state/compile_check.log` + `state/compile_failures.txt`.
- `debug/upstream_list.txt` — 70-chapter dependency-sorted publish list.
- `debug/extend_wave.py` — the wave-extension script used to build the extended
  `wave_upload.json` (defs + deferred thm/sol slugs).
- `state/defs_snapshot_0909/` — pre-edit copies of the 24 untracked def files
  (durable restore point).
- `scripts/wave_generate.py` — the ORIGINAL generator; emits correct
  `import Definitions.Def_*` lines. Committed with the `--defs-only` + always-`import
  Mathlib` edits (2026-09-10); `state/wave_manifest.json` reflects the 4 deferred
  chapters' nodes.
- `debug/regen_defs.py` — skeleton-inlining regen script; kept as reference only
  (inlining approach abandoned). Its remaining known bug: sub-namespace transitions
  (`namespace SignedShift` inside `NavierStokesFlow`) get dropped — fix in a debug
  folder if ever revisited.
- `ChapterNavierStokesSignedShift` def bundle now COMPILES (former blocker resolved) —
  its 29 thm nodes are candidates for a future wave.

---

## 5. Machine & environment facts (NixOS)

- Users: `leo` (human) and `oseditor` (agent). Agent may run anything as leo:
  `sudo -n -u leo <cmd>`.
- **Resilience layering for the upload (current setup, 2026-09-10):**
  - Shell logout / terminal close / tool-run process-group kill / process crash →
    the **setsid + nohup + disown + while-loop** wrapper in `start_upload.sh` (PID in
    `/tmp/upload_pipeline.pid`; logs `state/upload.log` + `state/pipeline.log`). The
    wrapper re-executes the pipeline on non-zero exit (rc=1 while work remains,
    rc=0 when done).
  - Machine **reboot** → the **systemd unit `upload-timepiece`** is `enabled`
    (WantedBy=multi-user.target, Restart=on-failure, RestartSec=30s; ExecStart runs
    `pipeline/upload_pipeline.py`; logs `state/service.log`). `local_compile`
    hardcodes the elan v4.33.1 lake path and reads `credentials.json` from the
    workspace, so the unit's minimal PATH is fine.
  - **Note: `sudo systemctl … upload-timepiece` is NOT NOPASSWD anymore.** leo's
    sudoers only grants NOPASSWD to `nixos-rebuild` and `remote-access-toggle`
    (verified 2026-09-10); starting/stopping the service needs leo's password
    interactively. The enabled unit is what survives a reboot; for everything short
    of a reboot the wrapper is sufficient.
- Workspace (canonical): `/home/leo/prove2me_workspace`. Contains `credentials.json`
  (**the API key**; gitignored; expires **2026-10-06**; re-mint via website or
  `POST /login` + `POST /agent/api-key`).
  **SECURITY: never send the key/token to any domain other than `https://prove2.me`;
  never commit or print it.**
- Toolchain: `leanprover/lean4:v4.33.1`, Mathlib pinned `0df444a360eaa60ab8c11dca51a86af692955474`
  (= the platform's default environment; matches exactly). ~6.5 GB prebuilt Mathlib
  oleans — do not delete. `lakefile.lean` has `autoImplicit false` + explicit
  `Definitions`/`Theorems`/`Solutions` (+`BookProof`) libs.
- Source project: `/home/leo/Projects/timepiece` (BUILT, v4.28 env) — required for the
  graph extractor and the Phase-0 axiom gate (`axiom_gate.lean`).
- elan on PATH for all lake work: `export PATH="/home/leo/.elan/bin:$PATH"`.
- **Compile gate** (before EVERY submission):
  `cd /home/leo/prove2me_workspace && lake env lean <file.lean>` — exit 0 = clean.
  Never use `/etc/profiles/per-user/leo/bin/lake` (it's v4.28.0 and blind to the
  workspace's v4.33.1 modules).
- Network: outbound HTTPS to prove2.me only (API) + github.com/cachix (workspace
  pulls, Mathlib caches).
- Keep ALL state inside the workspace — `/tmp` dies on reboot.

---

## 6. Lean & platform gotcha catalogue (do not rediscover)

### 6.1 Platform submission rules

- The server **ignores imports inside `formal_statement`** — imports/opens/variables
  go in the separate **`preamble`** field.
- A `formal_statement` starting with `/--` is silently **dropped** — strip leading
  docstrings.
- `formal_statement` must end `:= by sorry`; `theorem_name` must be the exact
  declaration name; conservative ASCII only (server rejects `'` — use `_prime`).
- Poll endpoints: publish jobs = `GET /publish-jobs/{job_id}` (path param);
  solution verdicts = `GET /verify?submission_id=…`. `submit-definition` returns one
  job object (top-level `job_id`); `submit-problem` returns `{"jobs": […]}`.
- Solution terminal statuses: `ACCEPTED` / `SKETCH_ACCEPTED` / `CE` / `FAILED`.
  Importing an Open theorem yields `SKETCH_ACCEPTED`; import Proved nodes for plain
  `ACCEPTED`.
- Server-side heartbeat timeouts: wrap heavy proofs with
  `set_option maxHeartbeats 1000000 in`.
- The 1-hour access token is cached 50 min by the uploader; `agent/refresh` mints one
  from the key.
- The workspace `lake build` mirrors the server environment exactly — green build =
  safe to submit.

### 6.2 v4.28 → v4.33.1 drift patterns (full detail: vendored translation plan §2)

- `grind` regressed (`+suggestions`/`+locals` leave goals open) → unfold bracket +
  `noncomm_ring` (import `Mathlib.Tactic.NoncommRing`).
- `ring`/`ring_nf` handle only **commutative** rings now — "made no progress" on bare
  `Ring R` → use `noncomm_ring`.
- `Ring → LieRing` instance removed →
  `attribute [local instance 100] LieRing.ofAssociativeRing` after
  `import Mathlib.Algebra.Jordan.Basic`.
- `convert … using 1` leaks instance-equality subgoals (goal ORDER varies per shape).
- Division-by-atom terms block `linarith` atom matching → pre-simplify with
  `simp only [add_mul, mul_div_assoc, div_mul_eq_mul_div]`.
- `∃ x > 0` elaboration changed; renames like `Real.rpow_le_rpow_of_exponent_le`.
- A `@[simp]` lemma may stop firing → add explicit `rw [lemma]`, drop the trailing
  `simp`.
- `smul_apply`/`sum_apply` ambiguous vs Matrix → qualify `Matrix.smul_apply` /
  `Matrix.sum_apply` (v4.33 additions).
- `Complex.ext_iff` now splits to entry-level `.re ∧ .im` — reduce
  `Complex.I • … • Complex.I • …` FIRST, then `ring` on the ℝ halves.
- `Dense.eq_zero_of_inner_left` now takes an explicit `𝕜`.
- `integral_mul_deriv_eq_deriv_mul_of_integrable` now wants `∀ x ∈ tsupport v`
  (wrap `fun x _ => hu x`).
- Fourier/Schwartz API: `𝓕` unfolds to
  `VectorFourier.fourierIntegral Real.fourierChar volume (innerₗ ℝ) …`; the
  `toSchwartzMap` coe fact is `rfl` (no simp lemma exists). `ℓ²` notation needs
  `open scoped lp`.

### 6.3 The convert/trace diagnostic recipe

When a proof fails with `ring_nf made no progress` or a drifted `convert`:

1. Replace the failing block with `convert … using 1; all_goals trace_state`
   (or bullets `· trace_state`).
2. Read the `case e'_N` order — instance goals leak first (e.g. AddCommGroup, Module
   instances), then defeq goals, then the numeric/ring goal.
3. Write bullets in EXACTLY that order (`· rfl · rfl · rfl · ring` — count varies).
4. For beta-redexed goals (`(fun x => …) a` shapes), `simp`/`ring` fail silently:
   beta-unfold first with `show <unfolded form>` (or `show` + the Pi lemma e.g.
   `Pi.add_apply`), THEN rewrite (`rw [add_mul]` etc.). Example that defeated plain
   `ring`/`simp`:
   `(hp.add hq).congr … ; show p * e + q * e = (p + q) * e ; rw [add_mul]`.

### 6.4 Workspace hygiene rules

- **Always `git status` before editing `Definitions/`.** A half-baked regen once broke
  the published `Def_ChapterSirkDiffusiveDecay` (duplicate `compress` decl: inlined
  copy + import); recovery cost a `git checkout HEAD -- Definitions/` + snapshot.
- **Never edit a def bundle already PUBLISHED on the platform** without first checking
  whether the edit is even needed (the platform will reject with `already exists` and
  self-heal reuse).
- Untracked new def files: restore point lives in `state/defs_snapshot_0909/`.
- Restore untracked files from a snapshot with `cp` — `git checkout` only covers
  tracked files.

---

## 7. API quick reference

```bash
cd /home/leo/prove2me_workspace
KEY=$(python3 -c "import json;print(json.load(open('credentials.json'))['api_key'])")
curl -s -X POST https://prove2.me/api/v1/agent/refresh -H 'Content-Type: application/json' \
  -d "{\"api_key\":\"$KEY\"}"    # → access_token (1 h)

# what's published / in flight
curl -s "https://prove2.me/api/v1/publish-jobs?kind=problem" -H "Authorization: Bearer $TOK"
curl -s "https://prove2.me/api/v1/theorems?tags=timepiece" -H "Authorization: Bearer $TOK"
curl -s "https://prove2.me/api/v1/theorems/{id}" -H "Authorization: Bearer $TOK"  # reliable node check

# service
./start_upload.sh status | start | stop | restart
tail -f state/pipeline.log state/upload.log

# compile gate
export PATH="/home/leo/.elan/bin:$PATH"
lake env lean Definitions/Def_<X>.lean          # single file
lake build Definitions.Def_<X>                  # module (cache-friendly)
debug/compile_check.sh                          # full 70-chapter gate
```

---

## 8. Scope rules & next waves

**Binding scope decisions (human):**

- **NO Riemann Hypothesis and NO P-vs-NP proofs** (the `Legacy.lean` chain rests on
  `sorryAx`).
- **Priority: QYM, NS (Navier–Stokes), QG, SIRK** BookProof chapters.
- **ESA chapters: NOT a target on their own** (binding, human, 2026-09-10). Only
  the **Friedrichs extension of the number operator `N`** lifts to the **outer Fock
  space**; the essential-self-adjointness (ESA) proofs on the one-particle
  Hamiltonians do NOT lift. So publish ESA content **only through the Faris–Lavine
  route** (`FarisLavine`, `FarisLavineCore`, the Faris–Lavine chapters) — standalone
  `*Esa` chapters (`FockWeightedSchurEsa`, `GradedBandSchurEsa`,
  `HermiteBandCalculus(Higher)`, `FullQuadraticEsa`, `QuadraticFockEsa`,
  `HermiteQuadraticEsa`, `ModeQuadraticEsa`, `OperatorSeriesEsa`, `ShiftedHermiteCore`,
  the ~30 other `*Esa` chapters) are **excluded from waves** (def bundles may be
  fixed/generated only if needed as an upstream dependency of a non-ESA chapter).
- Solutions must be axiom-clean: `#print axioms X` ⊆ `{propext, Classical.choice,
  Quot.sound}`. Phase-0 gate: `/home/leo/Projects/timepiece/axiom_gate.lean`
  (prefix-based over BookProof/PnpProof/UsedRoute/UnusedRoute/RandomMap; `grep '^BAD'`
  must be empty; sorryAx auto-flagged).
- **Source-folder rule: publish from ANY project folder EXCEPT `Book/`** (prose
  chapters). `wave_upload_spec.py` and the uploader hard-fail on `/Book/` sources.
- PnpProof/UsedRoute/UnusedRoute targets additionally need `axiom_clean: true` +
  `sorry_free: true` metadata from the gate run.

**Selection criteria for the next wave:** Mathlib-only (or fully published upstream
deps) > previously compiling > axiom-clean > priority QYM > SIRK > NS > QG > (ESA only
via Faris–Lavine).

**Candidate chapters not yet uploaded** (full list: LEGACY §10.2):

- QYM: ChapterYangMillsAbelianEsa, ChapterYangMillsAbelianFockEsa,
  ChapterYangMillsAbelianNoGap, ChapterYangMillsBandBounds,
  ChapterYangMillsCertificateSeam, ChapterYangMillsFockGapChain,
  ChapterQedAbelianConsolidation, ChapterYangMillsGhostSector.
- SIRK: ChapterSirkGapTable, ChapterSirkGramCutoff, ChapterSirkGramWhitening,
  ChapterSirkMultiShift, ChapterSirkRestart, ChapterSirkRitzPerturbation,
  ChapterSirkSingleTimeShift, ChapterSirkTrotterKato, ChapterSirkTrotterKatoGalerkin,
  ChapterSirkTruncation, ChapterSirkPerSystemFlowBound.
  (SirkDiffusiveDecay/EndToEnd/PerSystem/Whitening/SpectralGeometry are in the
  current wave or already published.)
- ESA: **EXCLUDED as standalone targets** (binding decision above — only the
  Friedrichs extension of `N` lifts to the outer Fock space, not the one-particle
  ESA proofs). Publish ESA content only via Faris–Lavine. (Formerly listed:
  ChapterFockWeightedSchurEsa, ChapterGradedBandSchurEsa,
  ChapterHermiteBandCalculusHigher, ChapterQuadraticFockEsa, plus the ~30 `*Esa`
  chapters — see LEGACY §10.2.)
- NS: ChapterNavierStokesSignedShift (29 thms — bundle now compiles),
  ChapterNavierStokesMomentumEsa, ChapterNavierStokesFockEsa,
  ChapterNavierStokesEsaConsolidation, and the rest of LEGACY §10.2's NS list.

**De-ESA of the FL chapters (2026-09-10):** `SqSumFarisLavine` and `GaussCoreQuadBounds` are
DONE -- their defs build without any non-FL ESA deps (embedded linForm/sqSumPoly/harmPoly,
dropped QgHermiteOscillatorEsa/HermiteQuadraticEsa imports) and are published (wave 9, +53 thms).
`QgOuterFockFarisLavine` de-ESA is ~85%: embedded the Friedrichs FormDom + HashimotoShiftInvert +
harmCore chains at root namespace; the last blocker is harmCore_symmetricOn/harmCore_quadForm_nonneg
which need the QgHermiteFriedrichs node network (hamCore_pgLp, hamPoly, gaussInt_kinPoly,
inner_potLp_symm, ...) -- re-implementing the Qg Hermite-oscillator ESA inside the FL chapter;
NOT pursued (would duplicate the excluded ESA content).  `SqSumOuterFamily`/`NsOuterFockFarisLavine`
wait on QgOuterFockFarisLavine (dsComparison/harmFried).

**Outer-Fock / Faris-Lavine progress (2026-09-10):** `NavierStokesFockFarisLavine` is PUBLISHED (wave 8,
12 thms, SecondQuant namespace). The remaining FL chapters (`SqSumFarisLavine`, `SqSumOuterFamily`,
`NsOuterFockFarisLavine`, `SqSumOuterSingleTime`) compile their defs but are blocked by a web of
NON-FL-ESA upstream deps (`QgOuterFockEsa` -> `Qg3DGaugeEsa`/`DirectSumEsa`/`FullQuadraticEsa`;
`HermiteQuadraticEsa`/`GaussCoreQuadBounds` also pulled in) -- excluded per the ESA decision, so
this chain is NOT pursued.  Embedded helpers `ExpBounded.nonneg_const`, `exists_exp_bound_mvPolyEval`,
`memLp_mul_pgFun_of_expBounded` in `Def_ChapterQgHermiteCore`, which unblocked `QgHermiteFriedrichs`
and `QgHermiteOscillatorEsa` (defs compile; not added to the wave since they are only needed by the
blocked FL chain).

**QG cluster status (2026-09-10):** `QgHermiteCore` is PUBLISHED (wave 5.5, 36 thms). The rest
of the QG chain is blocked on a cascade: `QgBrstDerivativeGauge` (needs `QgModeData` from the
mode-instance chapters) -> `QgVielbeinModeInstance`/`QgContinuumModeInstance` (needs ScalaronFiberFL/
ScalaronOuterFockFL/`QgOuterFockCoreFL` namespaces -- spurious opens mostly removable, but code uses
`QgModeData`) -> `QgOuterFockFlow` -> `QgTruncationResolvent` -> `SirkSingleTimeShift` ->
`QgTimeIndependentFlow` (12 thms). The mode-instance defs compile once their spurious opens are
dropped and FarisLavine is imported; `memLp_mul_pgFun_of_expBounded` (QgHermiteCore, a node) needs
embedding for `QgHermiteFriedrichs`/`QgHermiteOscillatorEsa` (dep of SqSum*/outer-Fock). To finish
the chain: generate + fix the missing mode-instance/Scalaron/outer-Fock def bundles, embed the node
helpers, then the SqSumFarisLavine/NsOuterFockFarisLavine Faris-Lavine chapters unblock.

**Future-wave playbook** (condensed; full: LEGACY §5.7): pick chapters → Phase-0
axiom gate in the timepiece env → generate (`scripts/wave_generate.py`; known
generator bugs in the translation plan §6: bogus `open` for dot-named theorems,
missing NoncommRing/Jordan imports) → validate in the workspace mirror until
`lake build` green → extend `wave_upload.json` → `./start_upload.sh start` →
batch hygiene (append-only state, update §1/§4 counts).

---

## 9. Git rules

- Workspace fork remote: `git@github.com:leonardopedro/prove2me_workspace.git` (SSH;
  HTTPS push lacks credentials). Push **only to the fork**.
- Upstream `prove2me/prove2me_workspace` is READ-ONLY: never push to it, never open
  PRs from the fork (permission denied by design). Sync direction fork ← upstream
  (pull) only.
- Timepiece origin: `git@github.com:leonardopedro/timepiece.git`.
- `credentials.json` and `state/` are gitignored or must stay out of commits — never
  commit the API key.
