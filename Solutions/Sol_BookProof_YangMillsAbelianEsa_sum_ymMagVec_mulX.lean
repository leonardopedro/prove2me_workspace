-- Generated from ChapterYangMillsAbelianEsa.lean — solution of BookProof.YangMillsAbelianEsa.sum_ymMagVec_mulX
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianEsa
import Theorems.Thm_BookProof_YangMillsAbelianEsa_sum_ymMagVec_X
open BookProof.YangMillsAbelianEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (m : Fin 24) :
    ∑ n : Fin 99, ((ymMagVec m n : ℝ) : ℂ) • mulXPoly (d := 99) n
      = mulOp (magPoly 0 (decodeSpace m) (decodeColor m)) := by

  refine LinearMap.ext fun p => ?_
  simp only [LinearMap.sum_apply, LinearMap.smul_apply, mulXPoly_apply, mulOp_apply]
  rw [← sum_ymMagVec_X m, Finset.sum_mul]
  exact Finset.sum_congr rfl fun n _ => by rw [smul_mul_assoc]
