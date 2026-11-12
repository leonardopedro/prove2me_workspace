# Session handoff — 2026-11-02 (Forms split shipped)

## UPDATE 09:20 — the blocked family below is CLOSED

- **`def:ChapterQgBrstDerivativeGaugeV2` published** (03:03:40, `def_id
  2364995f…`, 18 items, 25.7 KB) — full `BookProof.QgBrstDerivativeGauge`
  namespace (`gaugeReduce`, `extTorsionCoef` + supporting decls) with proofs.
- **`elimTorsion_eq_gaugeReduce` sol DONE** (03:19:10, `submission_id
  0c395f98…`); platform reports the theorem **`Proved`**.
- **QgFourierElim chain: 15/15 thm stubs + 15/15 sols `Proved`** (verified
  against the live API, not just the ledger).
- Local re-check with the required toolchain: sol compiles clean (exit 0, no
  diagnostics) through `timepiece331`'s `lake env lean`, **Lean 4.33.1**.
- The 7 old `QgBrstDerivativeGauge` thm stubs + 7 sols stay **parked as
  `dup-declared`** — the same verdict locally (`thm_gate.json`) and on the
  platform. Their names are declared **and proved inside the V2 bundle**, so
  the parks are correct (same disposition as `qgElim_esa`).
- The local `Def_ChapterQgBrstDerivativeGauge.lean` remains the stripped
  9-line served stub; the fan-out to V2 already landed (see "Files created/
  changed"). `state/def_gate.json`: V2 = OK.
- `def:ChapterQgSymmetricSector` / `def:ChapterQgFullEliminated` still gated
  OK, waiting on their dependency theorems — flowing via the drain
  (`debug/drain_loop.sh`, chunk loop healthy as of 09:12).

## What shipped

The §2.13 new-name surgery for `ChapterQgFourierElimination` is **complete and
published**. The platform's served copy of that bundle predates the Session-28
port (8 decls, 174 lines) and `submit-definition` refuses an existing name, so
the 22 missing decls were carved into a new bundle:

- **`Definitions/Def_ChapterQgFourierElimForms.lean`** — `FormIdx`,
  `torsionF`/`dGaugeF`/`gauge3dF`, `ind`, `gCoef` + eval lemmas, `mAbs`,
  `formValue` + the three new rewrite lemmas (`formValue_torsion_elimConfig`,
  `formValue_dGauge_elimConfig`, `formValue_gauge3d_elimConfig`), `gGram`
  (155 lines, 22 decls, compiles clean, no axiom/sorry).
- **Local `Def_ChapterQgFourierElimination.lean` stripped** to match the
  platform's served copy exactly (backup: `.bak_forms_split`); the 29 files
  that reference the carved names import the Forms bundle instead.
- `pipeline/wave_upload.json`: `ChapterQgFourierElimForms` def entry added
  (backup: `.bak_pre_forms`).

### Platform status (all verified against the live API)

| item | status |
|---|---|
| `def:ChapterQgFourierElimForms` | **DONE** (published) |
| QgFourierElim thm stubs | **14/15 done** |
| QgFourierElim sols | **14/15 done** (platform-verified proofs) |
| `def:ChapterQgFullEliminated`, `def:ChapterQgSymmetricSector` | gated OK, waiting on their dependency theorems being proved (flowing via the drain) |

Gates: `state/def_gate.json` refreshed for the 3 edited Def bundles
(`state/scratch/r29_forms_split.tsv` — 3 OK); `state/thm_gate.json` refreshed
for all 14 published stubs via `debug/gate_thm_ok.py`.

## The one blocked family (next chain)

**`elimTorsion_eq_gaugeReduce`** (thm stub + sol) is still pending: its
statement uses `gaugeReduce` / `extTorsionCoef`, which exist only in the local
`Def_ChapterQgBrstDerivativeGauge.lean` — the platform's copy of that bundle is
a **9-line stub with 0 decls** (verified live: node
`754b…`-style fetch, `definition` field = 9 lines).

Next step is the same §2.13 surgery, with a 22-file fan-out (5 Defs, 7 Thm
stubs, 10 Sols reference the bundle — list captured in the session log).
A previous attempt **`ChapterQgBrstDerivativeGaugeV2`** (2026-10-19) failed
only with `unknown import: Definitions.Def_ChapterQgContinuumModeInstance` —
that bundle published 6 days later, so the reason is obsolete. The failed
job's full payload is recoverable from
`GET publish-jobs?kind=definition` → job `ChapterQgBrstDerivativeGaugeV2` →
`definitions` field. Re-extract it into `Def_ChapterQgBrstDerivativeGaugeV2.lean`,
strip the local old bundle to the served 9 lines, repoint the 22 dependents,
regate, publish, then flip the stub/sol imports.

## Traps learned this session (do not repeat)

1. **`state/defs_index.json` is STALE.** It said
   `ChapterQgContinuumModeInstance` has 26 names and
   `ChapterQgBrstDerivativeGauge` is a stub; the live `definition` field of the
   node shows 331 lines / 32 decls for the former. Always verify against
   `GET theorems/<id>` → `definition`, never the index alone. (The index made
   me wrongly consider un-parking `qgContinuum_essentiallySelfAdjointOn`; the
   park is correct — the name is on the platform via the Def bundle, which is
   why `Sol_…_qgElim_esa` was fixed by **dropping** its Thm import, not by
   publishing the stub.)
2. **Never inline a `pgrep … upload_pipeline` wait loop in a `bash -c`
   background command** — the wrapper's own cmdline contains
   `upload_pipeline.py`, pgrep matches it, the loop never exits, and (worse)
   the drain's own pgrep then sees the stuck wrapper and stops chunking
   entirely (it did: 43 min of no chunks). Use `debug/idle_sync.sh` (script
   file, pattern in the file not the cmdline).
3. **`--sync` must run in the drain's idle window** (between chunk exit and
   the 180 s sleep). A sync that runs while a chunk is in flight gets
   clobbered: the chunk loaded pre-sync state and overwrites the reconciled
   records at its next save. `debug/idle_sync.sh` waits for idle, syncs, and
   writes `state/scratch/idle_sync.marker`.
4. **Chunks never call `sync_state`** — only `--sync` does. A thm published by
   an earlier process (or lost to a write race) stays `pending` in the ledger
   forever until an explicit `--sync` reconciles it from publish-jobs; every
   dependent sol then waits with `theorem not published yet`.
5. The dead `open BookProof.QgBrstDerivativeGauge` / import in generated
   stubs compiles locally (the mirror has the full bundle) but is rejected by
   the platform (served bundle has no namespace) — stripped from all 22
   QgFourierElim thm/sol files this session.

## Files created/changed this session

- `Definitions/Def_ChapterQgFourierElimForms.lean` (new), backup
  `Def_ChapterQgFourierElimination.lean.bak_forms_split`
- `Definitions/Def_ChapterQgFourierElimination.lean` (stripped to served copy)
- 29 dependents got `import Definitions.Def_ChapterQgFourierElimForms`
- 22 QgFourierElim thm/sol files: Brst import/open stripped
- `Solutions/Sol_BookProof_QgFourierElim_qgElim_esa.lean`: dropped the dup
  `import Theorems.Thm_…_qgContinuum_essentiallySelfAdjointOn`
- `pipeline/wave_upload.json` (+ `.bak_pre_forms`), `state/def_gate.json`,
  `state/thm_gate.json` (tool-generated)
- `debug/idle_sync.sh` (new helper), `state/scratch/idle_sync.*`,
  `state/scratch/regate_forms_targets.txt`, `state/scratch/r29_forms_split.tsv`,
  `state/scratch/thm10_only.txt`

---

## Session 2 (same day) — thm-stub defect triage over the true stalled set

### The stalled set, derived not recalled

The "17 FAIL" figure carried over was reconstructed from memory and was wrong
(it named six slugs that do not exist as files or ledger items: `…_secCore_dense`,
`QgFourierElim_fiberBasis`, `QgFourierElim_formValue`,
`starobinsky_qgOuterFock`, `QgFourierElim_sectors`, `…_gauge2d`).  Derived
properly from `state/pipeline.json` — `thm:` items with `attempts >= 1`, status
not `done`/`parked`, gate not `OK` — the real set is **37 items**:
`state/scratch/stalled37_slugs.txt`.

Ledger-wide context: 7245 thm `done`, 1650 `parked`, 1028 `pending`; 968 of the
pending have gate FAIL/UNKNOWN, but almost all are `attempts=0` and
dependency-deferred — they were deliberately NOT touched (burning no attempts).

### Defect taxonomy of the 37 (final gate: 6 OK / 31 FAIL, `state/scratch/gate37c.log`)

| class | n | treatment |
|---|---|---|
| stale verdict — compiles clean now that mirror oleans caught up | 6 | re-gated → `OK` |
| missing `Definitions.*` import / namespace `open` | 3 | fixed by `debug/add_missing_def_imports.py` |
| name declared **only in a `BookProof/` chapter** (the platform never uploads `BookProof/`; 0 Defs and 0 thm stubs import it) | 13 | **cannot compile as generated** — the fact must be promoted into a Def bundle (Defs are sorry-free, so that means porting the proof) or the statement rewritten to a published name |
| statement-level: `unknown universe level u` ×4, `Fields missing expE/expF` and `form_domain/selfAdjoint` ×2, `Invalid field secExt_rel` ×2, `unexpected token '²'` ×1 | 9 | statement repair, per-file |
| `has already been declared` (stub duplicates a published name) | 4 | park with `debug/park_dup_thms.py --input <list>` |
| mirror artifact `object file …olean` / missing `import Theorems.*` | 2 | rebuild mirror entry / add the import |

The 13 chapter-local names, verbatim:
`geoHop_isL2Kernel`, `PhysHSGaussian.sphereUniform` ×3 (only `gaussianE` was
inlined into `Def_ChapterG3`), `characterSpace` (actually Mathlib's
`WeakDual.characterSpace` — fixed by `open WeakDual`, now compiles),
`resolvent_mem_friedrichsDomain`, `qgScalaronPosSymOp_dense` ×2,
`contDiff_lcV` ×3, `blockVec_mem_maxDom[_prime]` ×2, `deg_pair_le_two`
(a doc-comment mention in the Def, not a declaration).

### Repaired earlier this session (all gate `OK`, retried by the drain at att=1)

`QgTimeIndependent_qgOuterFock`, `…_starobinsky_brstGaugeFixed`,
`…_starobinsky_qgManifold`, `SirkSingleTime_qgOuterFock`,
`…_starobinsky_qgContinuum`, `…_starobinsky_qgManifold`,
`QymTimeIndependent_ymFock_diagonalBasis`, `SirkSingleTime_isShiftInvertC_neg_resCLM_shift`,
`QgFourierElim_formValue_gauge3d` (via `--sync`), plus the 29-file broken-`open`
sweep.  Three of them needed `BookProof.QgCouplingDGammaSum.diagCol` qualified
(`diagCol` is ambiguous with `DiagonalDGamma.diagCol`), and the Sirk/QgTimeIndependent
stubs needed `Def_ChapterQgTruncationResolvent` + `Def_ChapterScalaronFiberFL`
imports/opens (`truncModes`, `starobinskyWall`) and `Def_ChapterQgBrstDerivativeGauge`
+ `Def_ChapterQgContinuumModeInstance` (`CMode`, `qgContinuumModes`).

### New tools

- `debug/unknown_ident_imports.py` — compile a stub, map every reported unknown
  identifier to the workspace module that declares it (`--jobs=N`, `--from-file`).
- `debug/add_missing_def_imports.py` — error-driven repair: compile first, add
  only the `Definitions.*` import + namespace `open` for identifiers the
  compiler itself named and that Definitions actually *declares* (declaration
  lines only, never doc comments).  Reports `UNFIXABLE` for chapter-local names
  and leaves them untouched; `--dry-run` supported.

### Traps learned this session (do not repeat)

6. **`pkill -f <pattern>` inside a compound background command kills its own
   wrapper** when the pattern string appears anywhere in that command line —
   the 6-stub gate silently never ran (empty stdout, no log).  Split the kill
   and the work into separate tool calls.
7. **Never reconstruct identifier lists from memory.**  Six phantom slugs were
   gated and "fixed" before noticing they have no source file and no ledger
   item.  Derive every work list from `state/pipeline.json`.
8. **A regex binder skip written as `(?:\[?[^\]]*\]?\s*)?` backtracks into the
   identifier** and captures a single trailing letter (`structure System` → `e`),
   which silently indexed 130 names instead of 10,939 and mislabelled 14
   stubs `UNFIXABLE`.  Require the bracket: `(?:\[[^\]]*\]\s*)?`.
9. **`(idents, notes) = ([], [])` was read as CLEAN by the caller** while it
   actually meant "failed, but not with an unknown identifier" — 14 real
   failures (already-declared, bad fields, bad universe levels) reported green.
   Return `(None, err)` for that case; a green verdict must only ever come from
   `returncode == 0`.
10. **Namespace tracking needs a stack**, not a reset-on-any-`end`: a single
    `ns = ""` on `end` dropped `BookProof.Complexification` and produced plans
    with `open=[]` that could not resolve.
11. Path builders double-prefix easily: `Sol_BookProof_` + a slug already
    starting with `BookProof_` silently checks a nonexistent path and reports
    `no sol file` for files that exist.

### Sols behind the repaired thm stubs (11 queued, `state/scratch/fixed_sols.txt`)

Re-checked after the thm repairs (`state/scratch/sol11b.log`):

- **2 compile clean**: `Sol_…_QgTimeIndependent_qgOuterFock…` and
  `Sol_…_SirkSingleTime_qgOuterFock…`.  Both needed the same
  `Def_ChapterQgTruncationResolvent` / `Def_ChapterScalaronFiberFL` /
  `Def_ChapterScalaronOuterFockFL` imports+opens their stubs got, plus
  `open BookProof.SirkSingleTime` for
  `qgOuterFock_singleTime_shiftInvert_convergence`.
- **8 blocked on a thm olean** (a sol imports its thm; if the thm stub does
  not compile, no `.olean` exists and the sol cannot even be parsed).  The 7
  missing mirror oleans were gated: 3 built OK, 4 still FAIL
  (`QgTruncationResolvent_momWindow_exhausts`,
  `QgManifoldModeInstance_VielbeinSpectrum_energyWindow_exhausts`,
  `ChapterStoneResolvent_UnboundedSelfAdjoint_resCLM_mem`,
  `YmAbelianFock_dGamma_ymAbelian_essentiallySelfAdjointOn_core`) — the chain
  is sol → thm → thm's own imports, so fix the thm first.
- **1 file is corrupt and has been since before this session**:
  `Solutions/Sol_BookProof_QymTimeIndependent_ymFock_diagonalBasis_timeIndependent_singleTime.lean`
  ends mid-expression at line 71 (`0 → … ((`, 72 `(` vs 69 `)`), and **git HEAD
  is truncated identically** (same 73 lines), as is `.bak_fix15` from Oct 6.
  The statement (lines 54–70) is complete and matches the thm stub; only the   proof tail is missing.  Ledger: `pending`, `attempts=0`, so it will burn
   attempts when reached.  **Needs reconstruction** — 0 of 10094 sols contain
   `sorry`, so the repo convention is a real proof; do not paper over it with
   `sorry`.

---

## Session 3 (same day) — the `-DautoImplicit=false` false-green, and the
## `formal_statement` boundary

### Trap 12 — a compile with plain `lean file.lean` is NOT the gate (worst trap of the session)

I "fixed" four `unknown universe level u` stubs and verified them with
`lean file.lean`, reported rc=0, and moved on.  Re-running through the real
gate flipped **all four back to FAIL**.  Reason: `debug/gate_thm_ok.py` (and
`build_candidate_mirror.compile_one`, the two oracles `upload_pipeline` trusts)
compile with **`-DautoImplicit=false`**; a bare `lean` invocation leaves
`autoImplicit` on, so an unbound `u`/`d` is silently auto-bound and the file
looks green.

**Any check that omits `-DautoImplicit=false` can pass a file the platform will
reject.**  Every verification in this repo must go through
`python3 debug/gate_thm_ok.py <slug>` with `CANDIDATE_MIRROR` set — never a
hand-rolled `lean` call.  The compiler even says so in the error:

```
Note: It is not possible to treat `d` as an implicitly bound variable here
      because the `autoImplicit` option is set to `false`.
```

### Trap 13 — only the text from `^theorem` onward is ever submitted

`upload_pipeline.py:889`:

```python
m = <regex ^theorem …>
formal = txt[m.start():].strip()      # becomes formal_statement
```

So **imports, `open`, `noncomputable section` and any `variable …` line before
the `theorem` never reach the platform.**  Adding `variable {d : ℕ}` above the
statement — the obvious fix, and the one I first reached for — is a **no-op
server-side**.  A variable the statement needs must be bound *inside* the
statement's own binders.  (Consequence: `formal_statement does not end with :=
by sorry` at :891 is a hard gate on the same string.)

### `QuantumGravity3DGauge_pderiv_comm_poly` — repaired, and a two-layer root cause

The same stub fails **differently in two contexts**, which is why the earlier
diagnosis looked contradictory:

| context | error | why |
|---|---|---|
| **platform** (served bundle) | unknown identifier `d` | served `state/published_bundles/Def_ChapterQuantumGravity3DGauge.lean` **lacks** `pderiv_comm_poly`, so no `variable {d : ℕ}` is in scope |
| **local / mirror** | `` `…pderiv_comm_poly` has already been declared `` | local + mirror bundle **have** it (line 202, proved) — bundle drifted ahead of the Oct-27 served copy |

The platform side is the one that matters for upload, and it is now fixed:

```lean
-- before
theorem BookProof.QuantumGravity3DGauge.pderiv_comm_poly (j k : Fin d) …
-- after
theorem BookProof.QuantumGravity3DGauge.pderiv_comm_poly {d : ℕ} (j k : Fin d) …
```

`{d : ℕ}` implicit matches what the source's `variable {d : ℕ}` elaborated to,
so the statement is unchanged in meaning.  Verified by extracting **exactly**
what `:889` sends and compiling it standalone under `-DautoImplicit=false`
(`state/scratch/qg3d_formal_check.lean`):

- **before:** rc=1, unknown identifier `d` ×3
- **after:** rc=0, only the `declaration uses sorry` warning

The local gate still reports `already been declared` — that is the *separate*
bundle-drift condition above, not a defect in the repaired statement.  Same
story for `QgMultiHalfDensity_…intertwines_multOp` (served bundle lacks it,
local has it), so **category A below is a local-vs-served drift artifact, not a
statement defect.**

### Full 37 re-gate — `state/scratch/gate37d.log` (was `gate37c.log`)

`CANDIDATE_MIRROR=$PWD/state/mirror`, `--jobs 6` (memory: 15 GiB total, 11
available — `regate_capped.sh` caps the heavier builds at 11 GiB).

| | before | after |
|---|---|---|
| **OK** | 6 | **15** |
| **not OK** | 31 | **22** |

The +9 are exactly this session's statement repairs, all now `OK`:
4 × `ChapterSeparableL2Model_*` (`universe u`/`v`),
`ChapterWeylSL2Group_isExpOfSl2_stdRep` +
`FriedrichsSquare_isFriedrichsSqExtension_factorRel` (missing struct fields →
`:= by sorry`), `FriedrichsCanonical_unbounded_friedrichs_canonical_example`
(`open scoped lp` for `²`), and 2 × `QgOuterFockInteractionFL_*`
(`secExt_rel` via the V2 bundle).

### The remaining 22, categorised

| class | n | members / fix |
|---|---|---|
| **A. `has already been declared`** — local bundle ahead of served | 4 | `QgMultiHalfDensity_…intertwines_multOp`, `QuantumGravity3DGauge_pderiv_comm_poly` (both platform-fixed, see above), `WallDeficiencyObstruction_IsL2Ode_{continuous,memLp}` (**correctly parked** dups) |
| **D. `Unknown identifier`** — name lives only in a `BookProof/` chapter | 15 | `geoHop_isL2Kernel`, `lpFiniteModes` ×2, `PhysHSGaussian.sphereUniform` ×3, `mulRep`, `resolvent_mem_friedrichsDomain`, `qgScalaronPosSymOp_dense` ×2, `contDiff_lcV` ×3, `blockVec_mem_maxDom[_prime]` ×2 — promote into a Def bundle or rewrite to a published name (`debug/add_missing_def_imports.py` reports these `UNFIXABLE`) |
| **C. import failure** | 1 | `QuantumGravityFock_superBracket_bosOp_ghostOp` — `import Theorems.Thm_…_FockOfFock_confEnergy_zero` collides with `Definitions.Def_ChapterNavierStokesFockEsa`, which already declares `confEnergy_zero` (the thm stub for it is itself a dup) |
| **E. `overloaded, errors`** | 1 | `QgPhysicalSectorIdentity_coupling_essentiallySelfAdjointOn_core` |
| **F. missing dep olean** (staging, not content) | 1 | `ScalaronHermiteEsa_scalaronPot_stone_flow` needs `Thm_…_continuous_scalaronPot.olean` built in the mirror |

New vs. the Session-2 list of 13: `lpFiniteModes` ×2 and `mulRep`.
`deg_pair_le_two` is gone from the set.

### Earlier this same session (already done, recorded here for continuity)

- **Dup-thm detector fixed** in `upload_pipeline.py`: it required a single
  `namespace BookProof.WallDeficiencyObstruction.IsL2Ode` line, but bundles open
  namespaces incrementally (`namespace BookProof.WallDeficiencyObstruction` +
  `lemma IsL2Ode.continuous`); it now also reads
  `state/published_bundles/` (served text) **first**, mirror second, local last.
  That served-first read is what exposed the `QgMultiHalfDensity` false park.
- **Parks:** `WallDeficiencyObstruction_IsL2Ode_{continuous,memLp}` thm+sol
  parked (genuine dups).  `QgMultiHalfDensity_…intertwines_multOp` and
  `QuantumGravity3DGauge_pderiv_comm_poly` were **un-parked / left pending** —
  served bundles lack both names.
- **`Def_ChapterQgOuterFockInteractionFLV2.lean` created, gated OK and
  published** (`def_id 7e1bfeb0…`), carrying the sorry-free
  `secExt_rel n u := (F.secData n).ext_norm_le u`; both `QgOuterFockInteractionFL`
  stubs repointed at it, `blocked_by → None`.
- **`Sol_BookProof_QymTimeIndependent_ymFock_diagonalBasis_…` rebuilt** — the
  header/statement were intact, only the proof tail was garbage; spliced the
  source's 3-line proof from `timepiece331/BookProof/ChapterQymTimeIndependentFlow.lean`.
  Compiles rc=0.

### Trap 14 — gate against `state/mirror`, not the script's `/tmp` default

`debug/gate_thm_ok.py` defaults `CANDIDATE_MIRROR` to `/tmp/def_candidate`,
but **AGENTS.md rule 4 forbids `/tmp`** (tmpfs: wiped on reboot, an OOM event
takes the machine down — 2026-10-27) and that directory is a stale partial anyway — 875 `Theorems/`,
0 `Solutions/`, 1090 oleans vs `state/mirror`'s 3679 / 1202 / 1833.  Always:

```bash
export CANDIDATE_MIRROR=$PWD/state/mirror
python3 debug/gate_thm_ok.py --from-file state/scratch/stalled37_slugs.txt --jobs 6
```

Note `gate_thm_ok.py` still writes its per-slug log to `/tmp/gate_thm_*.log`
(its own line) — read it for the untruncated error, then don't rely on it
surviving a reboot.

### Files created/changed this session

- `Theorems/Thm_BookProof_QuantumGravity3DGauge_pderiv_comm_poly.lean` —
  bound `{d : ℕ}`
- the 9 repaired stubs listed above (4 × `ChapterSeparableL2Model_*`,
  `ChapterWeylSL2Group_isExpOfSl2_stdRep`,
  `FriedrichsCanonical_unbounded_friedrichs_canonical_example`,
  `FriedrichsSquare_isFriedrichsSqExtension_factorRel`,
  2 × `QgOuterFockInteractionFL_*`)
- `pipeline/upload_pipeline.py` — dup detector reads served bundles first +
  handles incrementally-opened namespaces
- `Definitions/Def_ChapterQgOuterFockInteractionFLV2.lean` (new, published)
- `Solutions/Sol_BookProof_QymTimeIndependent_ymFock_diagonalBasis_…lean`
  (reconstructed proof tail)
- `state/scratch/gate37d.log`, `state/scratch/qg3d_formal_check{,_OLD}.lean`,
  `state/thm_gate.json` (tool-generated)
