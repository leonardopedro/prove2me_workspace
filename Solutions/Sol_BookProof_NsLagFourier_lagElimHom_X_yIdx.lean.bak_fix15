-- Generated from ChapterNsLagrangianFourierElimination.lean — solution of BookProof.NsLagFourier.lagElimHom_X_yIdx
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination
import Theorems.Thm_BookProof_NsLagFourier_lagElimHom_X
open BookProof.NsLagFourier




open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (l : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (j : Fin 3) :
    lagElimHom l n (X (ycoord p (yIdx j))) = 0 := by

  simp only [lagElimHom_X, ycoord, Equiv.symm_apply_apply, lagElimCoord_yIdx, map_zero]
