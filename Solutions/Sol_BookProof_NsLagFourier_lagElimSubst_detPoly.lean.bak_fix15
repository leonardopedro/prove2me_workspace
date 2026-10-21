-- Generated from ChapterNsLagrangianFourierElimination.lean — solution of BookProof.NsLagFourier.lagElimSubst_detPoly
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination
import Theorems.Thm_BookProof_NsLagFourier_lagElimSubst_cofPoly
open BookProof.NsLagFourier




open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (l : Fin 3 → ℝ) (n : ℕ) (p : Fin n) :
    lagElimHom l n (detPoly p) = 0 := by

  rw [detPoly, map_sum]
  refine Finset.sum_eq_zero fun j _ => ?_
  rw [map_mul, lagElimSubst_cofPoly, mul_zero]
