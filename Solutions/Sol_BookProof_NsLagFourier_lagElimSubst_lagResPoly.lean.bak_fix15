-- Generated from ChapterNsLagrangianFourierElimination.lean — solution of BookProof.NsLagFourier.lagElimSubst_lagResPoly
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination
import Theorems.Thm_BookProof_NsLagFourier_C_neg_one_real
import Theorems.Thm_BookProof_NsLagFourier_lagElimHom_C
import Theorems.Thm_BookProof_NsLagFourier_lagElimHom_X_accIdx
import Theorems.Thm_BookProof_NsLagFourier_lagElimHom_X_sIdx
import Theorems.Thm_BookProof_NsLagFourier_lagElimSubst_piola
open BookProof.NsLagFourier




open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (l : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    lagElimHom l n (lagResPoly p i)
      = X (lRedIdx p (accIdx12 i))
        + C (((∑ j : Fin 3, (l j) ^ 2 : ℝ)) : ℂ) * X (lRedIdx p (vIdx12 i)) := by

  simp only [lagResPoly, map_add, map_mul, lagElimHom_C, C_neg_one_real n,
    lagElimHom_X_accIdx, lagElimHom_X_sIdx, lagElimSubst_piola, add_zero]
  ring
