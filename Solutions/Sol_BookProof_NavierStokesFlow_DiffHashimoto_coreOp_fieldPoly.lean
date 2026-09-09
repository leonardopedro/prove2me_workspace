-- Generated from ChapterNavierStokesDiffHashimoto.lean — solution of BookProof.NavierStokesFlow.DiffHashimoto.coreOp_fieldPoly
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffHashimoto
import Theorems.Thm_BookProof_NavierStokesFlow_DiffHashimoto_coreOp_id
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
theorem solution (i : Fin 3) : coreOp (fieldPoly A c i) = fieldOp A c i := by

  rw [fieldPoly, fieldOp, coreOp_add, coreOp_smul, coreOp_id, coreOp_sum]
  congr 1
  exact Finset.sum_congr rfl fun k _ => by rw [coreOp_smul, posOp]
