-- Generated from ChapterNavierStokesDiffHashimoto.lean — solution of BookProof.NavierStokesFlow.DiffHashimoto.nsDiffH_eq_coreOp
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffHashimoto
import Theorems.Thm_BookProof_NavierStokesFlow_DiffHashimoto_coreOp_fieldPoly
import Theorems.Thm_BookProof_NavierStokesFlow_DiffHashimoto_half_cast
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffHashimoto








open Filter Topology



open MvPolynomial
open BookProof.FarisLavine BookProof.HashimotoShiftInvert BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteRelative
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
theorem solution : coreOp (nsDiffPoly A c) = nsDiffH A c := by

  rw [nsDiffPoly, nsDiffH, coreOp_sum]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [BookProof.YangMillsHermite.weylProd, coreOp_smul, coreOp_add, coreOp_comp, coreOp_comp,
    coreOp_fieldPoly, half_cast]
  rfl
