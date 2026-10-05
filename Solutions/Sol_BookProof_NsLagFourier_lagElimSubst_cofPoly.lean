-- Generated from ChapterNsLagrangianFourierElimination.lean — solution of BookProof.NsLagFourier.lagElimSubst_cofPoly
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination
import Theorems.Thm_BookProof_NsLagFourier_C_neg_one_real
import Theorems.Thm_BookProof_NsLagFourier_lagElimHom_C
import Theorems.Thm_BookProof_NsLagFourier_lagElimHom_X_fIdx
import Theorems.Thm_BookProof_NsLagFourier_rankOne_cof_zero
open BookProof.NsLagFourier




open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (l : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i j : Fin 3) :
    lagElimHom l n (cofPoly p i j) = 0 := by

  have h := rankOne_cof_zero (n := n) (fun c => C (Complex.I * (((l c : ℝ)) : ℂ)))
    (fun r => X (lRedIdx p (xiIdx12 r))) i j
  simpa only [cofPoly, map_add, map_mul, lagElimHom_C, lagElimHom_X_fIdx,
    C_neg_one_real n] using h
