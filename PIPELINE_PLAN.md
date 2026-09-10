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

**Status (2026-09-10):**

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
