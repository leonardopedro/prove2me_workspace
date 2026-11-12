# Handoff — regate campaign (r42/r43), written 2026-10-29 (2nd session)

## Goal
Drive `state/def_gate.json` (503 OK / 41 FAIL / 188 BLOCKED at start of this leg)
to zero FAIL except `QgFullEliminated` (known/accepted). Gate run via
`bash debug/regate_capped.sh state/scratch/<list>.txt rNN` (per-target cap,
watch_tree, no OOM).

## Completed this session
1. **Slash-import fix**: 12 `import Theorems/...` (slash) lines across 7 files
   rewritten to dotted form (batch b5 had written `Theorems/` module paths).
2. **Round-8 imports (5 added, cycle-checked)**: NavierStokesFockEsa ←
   Thm_.._FockOfFock_creat_basis; Note68AllModes ← Thm_.._solidHarmonicIm_harmonic;
   ScalaronFiberFL ← Thm_.._ScalaronWallEsa_kinOpR_apply; SqSumFarisLavine ←
   Thm_.._GaussCoreQuadBounds_norm_harmPoly_mul_le_shiftNorm; VielbeinFiberFock ←
   Thm_.._ScalaronFock_fockSmoothPotential_symmetric. Backups: `state/scratch/b8/`.
3. **harmCore_pgLp cycle resolved (partial)**: removed
   `import Definitions.Def_ChapterGaussCoreQuadBounds` from
   `Theorems/Thm_BookProof_QgHermiteOscillator_harmCore_pgLp.lean` (only edge
   reaching HermiteQuadratic; proof is `sorry`, statement needs it not — VERIFY
   the stub still compiles) and added `import Theorems.Thm_BookProof_QgHermiteOscillator_harmCore_pgLp`
   to `Def_ChapterHermiteQuadraticEsa`. Backup `state/scratch/b9/`.
   **HermiteQuadraticEsa now fails at 1:0 `object file …harmCore_pgLp.olean does not exist`**
   — the edited stub's olean must be rebuilt (defs-only sync does NOT rebuild
   Thm modules; rerun the Thm precompile step or sync with --scope all).
4. **ScalaronWallEsa exists_deriv2 cycle resolved by inline**: spliced the whole
   `namespace BookProof.WeakSecondDeriv … end` block (254 lines, lines 66–319 of
   `Def_ChapterWallDeficiencyObstruction.lean`, itself inlined from source
   chapter) into `Def_ChapterScalaronWallEsa` before
   `namespace BookProof.ScalaronWallEsa`. Backup `state/scratch/b9/`.
   Now fails at 82:27 unknown `exi…` — the block needs helper lemmas that
   WallDeficiencyObstruction got from ITS import list (compare
   `Thm_BookProof_WeakSecondDeriv_*` stub imports of WallDeficiencyObstruction
   vs ScalaronWallEsa and add the missing ones).

## Current sync fails (state/scratch/sync_stale_r43pre.log) — 11
| File | First error | Notes |
|---|---|---|
| BookBrstYangMills | 661 rewrite failed | proof fix |
| HermiteQuadraticEsa | 1:0 missing harmCore_pgLp olean | rebuild stub (item 3) |
| MixedLinearEsa | 211 type mismatch | proof fix |
| NavierStokesFockEsa | 427 cannot omit referenced section variable | import added shifted variables; add explicit var or `variable` line |
| Note68AllModes | 67 unknown `solid…` | import added but not rebuilt yet |
| TwoParticleSectorEsa | 70 simp made no progress | proof fix |
| PermutationSectorEsa | 283 type mismatch after simp | proof fix |
| ScalaronWallEsa | 82 unknown `exi…` | item 4 import gap |
| ScalaronFiberFL | 383 unknown `in…` | peeled (kinOpR fix took) — provider lookup |
| SqSumFarisLavine | 277 unknown `s…` | peeled (norm_harmPoly fix took) — provider lookup |
| VielbeinFiberFock | 188 unknown | peeled (fockSmoothPotential fix took) — provider lookup |

## Key facts / traps
- Sync: `python3 debug/sync_stale_mirror.py --scope all --defs-only`
  (env: TIMEPIECE_PROJ, CANDIDATE_MIRROR=$PWD/state/mirror,
  PROVE2ME_SKIP_LOCAL_COMPILE=1). Thm stubs must be precompiled separately.
- Provider-lookup pattern: grep `(theorem|lemma|def…) <name>` over
  Definitions/Theorems/Solutions; prefer Thm stub import; if cycle
  (reaches(importer, target)), either prune stub imports (sorry proofs import
  freely) or inline the block from WallDeficiencyObstruction/source.
- `Def_ChapterWeakSecondDerivative` is a hollow shell (sections 4–6 empty) in WS,
  mirror AND published copy — by design; consumers inline §4–§6.
- Backups: `state/scratch/b8/`, `state/scratch/b9/`, `state/scratch/b5..b7`.
- **User asked to be reminded to restate the original requests before any final
  report** (per earlier instruction).

## Next steps (in order)
1. Rebuild Thm oleans (incl. edited harmCore stub), rerun sync → expect
   HermiteQuadratic, Note68 to flip OK.
2. Fix ScalaronWallEsa 82 (import gap vs WallDeficiency import list).
3. Provider-lookup the 3 peeled unknowns (ScalaronFiberFL 383 `in…`,
   SqSumFarisLavine 277 `s…`, VielbeinFiberFock 188) + NavierStokesFockEsa 427
   section-variable error; then the 4 proof fixes (BookBrst 661, MixedLinear 211,
   TwoParticle 70, Permutation 283) — compare source copies under
   `/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/` (source tree used earlier).
4. Rerun sync until 0 FAIL; then regate wave r43:
   `python3 -c "import json;print('\n'.join(t for t,v in json.load(open('state/def_gate.json')).items() if isinstance(v,dict) and v.get('status','').startswith('FAIL')))" > state/scratch/regate_r43_targets.txt`
   `bash debug/regate_capped.sh state/scratch/regate_r43_targets.txt r43`
5. Repeat peel cycle until only QgFullEliminated remains FAIL.

---

## Leg 2 (2026-10-30) — sync peel, wave r43 groundwork

### Done this leg (all backed by backups in `state/scratch/b15..b18/`)
- **QgBrst chain root cause found**: `Definitions/Def_ChapterQuantumGravityBrstCharge.lean:279`
  failed on `brst_charge_nilpotent` because WS `Def_ChapterBRSTNilpotent` is *hollow*
  (97 lines vs source 249 — theorems extracted to Thm stubs). Added cycle-safe
  `import Theorems.Thm_BookProof_BRSTNilpotent_brst_charge_nilpotent` (stub imports only
  Mathlib + Def_ChapterBRSTNilpotent). This unblocks QG → BookBrstYangMills (its 719
  `brst_full_nilpotent` unknown was the stale QG olean; 661/673 `sub_mul`/`sum_sub_distrib`
  pattern failures are also expected to clear once QG's fresh olean is in the mirror —
  WS text is byte-identical to the compiling source chapter, verified by diff).
- **NavierStokesFockEsa:447** fixed — added `import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_lpBasis_total`.
  Re-ran sync: **OK (8.9s)**.
- **PermutationSectorEsa**: added stub imports `Thm_BookProof_TensorPerm_purePow_ne_zero` +
  `Thm_BookProof_TensorPerm_inner_purePow` (fixed 518/571/573 unknowns), reverted my
  earlier `simpa [restrictOp_apply]` → `simpa using` (namespace-form name doesn't resolve;
  `restrictOp_apply` is `@[simp]` anyway). One error left: 285 `simpa` type mismatch.
- **TwoParticleSectorEsa**: added `import Theorems.Thm_BookProof_ReducedEsa_mem_sector_symProj_iff`
  (fixes 254 unknown), reverted `simp [map_zero]` → `simp`. Remaining errors: 71/74 zero-case
  `simp` no-progress on `swapTwo X (swapTwo X 0) = 0`, 82 `inner_map_map` metavars,
  233 `simpa` restrictOp mismatch, 270/281/294 `redOp` application mismatches.
- **MixedLinearEsa**: patched calc step (b15) — but gate shows it BLOCKED upstream by
  `Def_ChapterFourierMultiplierEsa`, so re-verify after that root is fixed.
- **GraphCoreTransfer (ROOT)**: `pushOp_apply` was silently dropped by the bundle
  generator (source has it at 308, WS had nothing — no Thm stub either). **Inlined the
  8-line theorem from source** before its `rw [pushOp_apply` use. This unblocks
  TensorGraphCore → TensorPermutation → TwoParticle/Perm + many others. BACKUP b18.
- Killed an accidental `--scope all` sync (8966 modules) — **always run:
  `python3 debug/sync_stale_mirror.py --scope closure-of-fails --defs-only`**.
  NOTE: sync restores OLD .lean+.olean in `state/mirror` for any module that fails, so a
  FAILing dependency (like GraphCoreTransfer until now) poisons downstream compiles —
  fix roots first.

### Full 41-FAIL root list with unknown-name provenance (from state/def_gate.json)
Run this pattern per root: name present in source chapter but absent in WS Def file ⇒
**inline from source** (proven drop); name absent from both ⇒ find provider bundle/Thm stub
and add a cycle-checked import (+ `open` if bare name used).

Roots (`status` starts with FAIL, everything else is BLOCKED behind them):
A3i(spinor_inv_eq src-only), A4d(upsilon_re), AttentionResponse(headOutput_eq_sum),
CarlemanGeneralHop(CarlemanTwoStep), CoherentThermalFidelity(hasSum_expSeries),
EsaClosureCore(ambiguous term 426), FlowDGammaEsa(mulSA_position_unbounded),
FockQuadraticEsa(commForm_eq_neg_two_im), GraphCoreTransfer(pushOp_apply DONE),
HalfLineLimitCircle(BookProof. namespace), HermiteGraphApprox(missing object file —
rebuild dep), HermiteLadderOrder(import Thm_BookProof_StrichartzWave_exists_smoo... broken),
LorentzRealRepFull(finrank_WHalf), MackeyGeneralBase(ImprimitivitySystem src-only),
NavierStokesDeficiency(hasZeroDeficiencyOn_of_total_eigenvectors),
NavierStokesFockCanonical(sqrt_mul_sqrt), NavierStokesHashimoto(IsShiftInvertC),
NavierStokesLagrangianKatoRellich(syntax 153), NsOneBodyDGamma(broken Thm import
QgOuterFockFL_harmFried_op_co), NumericalRangeCrouzeix(inner_sub_const_smul src-only),
Qg3DGaugeEsa(namespace BookProof.YangMil...), QgCouplingDGammaSum(dGamma_eq_sum),
QgFullEliminated(KNOWN/expected to stay FAIL), QgPhysicalSectorIdentity(broken Thm import
QuantumGravity3DGaug...), QuadraticFockEsa(broken Thm import StrichartzWave_exists_smooth),
QuantumGravityBrstCharge(FIXED this leg), ScalaronDensitizedTransfer(boundedEnergyCore_dense),
ScalaronFockEsa(confV), ScalaronHermiteEsa(exists_exp_bound_mvPolyEval),
ScalaronWallEsa(invalidField differentiable 255), SirkEndToEnd(syntax 121),
SirkGramWhitening(import Def_ChapterSirkDiffusiveDecay failed), SirkPerSystemFlowBound(sirk_end_to_end_crouzeix_domain),
SirkRitzSpectrum(syntax 110), SmDiracYukawa(inner_eq_sum),
SqSumOuterSingleTime(broken Thm import QgOuterFockFL_harmFried_),
StoneResolvent(UnboundedSelfAdjoint — declared in WS elsewhere, used at line 32 before
its import/scope: add the provider import), StrichartzHermiteQG(simp type mismatch 72),
YangMillsAbelianFockEsa(import Def_ChapterLeafGaps failed, environment),
YangMillsFriedrichs(krylov_bestApprox_antitone), Complexification(Cx src-only).

### Ordered next steps
1. Run scoped sync again (GraphCoreTransfer now fixed) — expect Tensor chain to peel:
   TensorGraphCore → TensorPermutation → TwoParticle/Perm; check whether TwoParticle 71/82/233
   and Perm 285 clear (they may all stem from the stale GraphCoreTransfer olean; if not,
   their `simpa`/`simp` failures are env diffs vs source — diff imports against the source
   chapter and strip spurious extra imports if needed).
2. Inline source-only missing theorems for roots: A3i, MackeyGeneralBase,
   NumericalRangeCrouzeix, Complexification (same recipe as pushOp_apply: extract block
   from `$TIMEPIECE_PROJ/BookProof/ChapterX.lean`, insert before first use, backup first).
3. Broken Thm-import roots (1:0 errors): NsOneBodyDGamma, QgPhysicalSectorIdentity,
   QuadraticFockEsa, SqSumOuterSingleTime, HermiteLadderOrder — the stub file names are
   truncated in the gate; `ls Theorems/ | grep <prefix>` to find the real name, fix the
   import line (watch for the old `Theorems/` slash-form bug).
4. Syntax-error roots (unexpected identifier): SirkEndToEnd 121, SirkRitzSpectrum 110,
   NavierStokesLagrangianKatoRellich 153 — compare against source; likely corruption or a
   stray generated line.
5. Provider-import unknowns (name in neither WS nor its own source): hunt with
   `grep -rn 'theorem <name>' Definitions/ Theorems/` and add cycle-checked import (+open).
6. Re-run `python3 debug/sync_stale_mirror.py --scope closure-of-fails --defs-only`,
   iterate 1–5 until only `ChapterQgFullEliminated` fails.
7. Regate wave r43: `bash debug/regate_capped.sh <targets.txt> r43` (41 targets from
   `state/def_gate.json`), verify verdicts.
8. Per standing instruction: ask the user to restate the original requests before any
   final report.

### TwoParticle diagnosis state (unresolved, deep trail)
All verified so far — **WS text is byte-identical to the still-compiling source chapter**
(`lake build BookProof.ChapterTwoParticleSectorEsa` = success, replayed), and the mirror
environment signatures are **identical to the BookProof environment** for every declaration
used in the failing statements (probed `@redDom`, `@redOp`, `@essentiallySelfAdjointOn_red`,
`@EssentiallySelfAdjointOn`, `@SymmetricOn`, `@commutes_symProj` — printed side by side,
same types). Also ruled out:
- `-DautoImplicit=false` (fails with and without);
- extra imports FarisLavine/GraphCoreTransfer/stub (fails with exactly the source's 3 imports);
- stale mirror oleans (forced rebuild of FarisLavineCore, FarisLavine, GraphCoreTransfer,
  ReducingSubspaceEsa, TensorGraphCore — all rc=0 — still 9 errors);
- error cascade from the swapTwo cluster (commenting it out leaves the 6 Application mismatches).

Failing shape: in the 6 statements at ~268/279/292/307/386/393, Lean reports
`Application type mismatch ... in the application @EssentiallySelfAdjointOn ?m.25 ?m.26 ?m.27 ?m.33 (redOp ...)`
— **arg1 (`redDom (bosonicProj Hs) (sectorDom Hs D₂ 2)`) is never elaborated** (all of
F/instances/D still fresh mvars) while arg2 (redOp) is fully elaborated; then
`↥?m.33 →ₗ[ℂ] ?m.25` can't unify with `↥(redDom ...) →ₗ[ℂ] ↥(sector ...)` (coeSort not invertible).
The identical statement compiles in the BookProof env. Next probes to run:
1. Locate `bosonicProj`'s definition (grep `def bosonicProj` — unknown to the 2-import probe,
   so it is local to this file or comes via another import) and check whether its elaboration
   silently differs; try `set_option trace.Elab.step true` (or `pp.universes`) around line 266
   in the mirror compile to see the arg1 postponement reason.
2. Compare `#check @swapH_mem_sectorDom`/`sectorOp_swapH`/`isReducingProjection_bosonicProj`
   in both envs (source file defines them locally — compare with `set_option pp.explicit` output).
3. Possible quick repair if diagnosis stalls: rewrite each failing statement to pass
   `redDom`/`redOp` via the `essentiallySelfAdjointOn_red` form used successfully in
   `Def_ChapterReducingSubspaceEsa:165` / `Def_ChapterPermutationSectorEsa:409`, or add an
   explicit `F`-binder: `EssentiallySelfAdjointOn (D := redDom (bosonicProj Hs) (sectorDom Hs D₂ 2)) ...`
   (named D arg forces arg1 elaboration first).
Also note: `swapTwo` zero-case `simp` (71/74) and `inner_map_map` (82) still fail; source
relies on env differences there too — same trail.
4. Ruled out as well: name ambiguity — Mathlib has NO root `EssentiallySelfAdjointOn`
   (`#check @EssentiallySelfAdjointOn` with only `import Mathlib` = unknown identifier), so
   the opened custom one is the unique candidate in both envs.
