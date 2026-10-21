-- Generated from ChapterNsLagrangianFourierElimination.lean — solution of BookProof.NsLagFourier.lagElimSubst_volumePoly
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination
import Theorems.Thm_BookProof_NsLagFourier_C_neg_one_real
import Theorems.Thm_BookProof_NsLagFourier_lagElimHom_C
import Theorems.Thm_BookProof_NsLagFourier_lagElimSubst_detPoly
open BookProof.NsLagFourier




open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (l : Fin 3 → ℝ) (n : ℕ) (p : Fin n) :
    lagElimHom l n (volumePoly p) = -1 := by

  rw [volumePoly, map_add, lagElimSubst_detPoly, zero_add, lagElimHom_C, C_neg_one_real n]
