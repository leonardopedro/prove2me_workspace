-- Generated from ChapterNsLagrangianFourierElimination.lean — solution of BookProof.NsLagFourier.lagElimHom_X_vgIdx
import Mathlib
import Definitions.Def_ChapterNsLagrangianFourierElimination
import Theorems.Thm_BookProof_NsLagFourier_lagElimHom_X
import Theorems.Thm_BookProof_NsLagFourier_lagElimCoord_vgIdx
open BookProof.NsLagFourier




open MvPolynomial
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.NsFullLagrangian

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (l : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i j : Fin 3) :
    lagElimHom l n (X (ycoord p (vgIdx i j)))
      = C (Complex.I * (((l j : ℝ)) : ℂ)) * X (lRedIdx p (vIdx12 i)) := by

  simp only [lagElimHom_X, ycoord, Equiv.symm_apply_apply, lagElimCoord_vgIdx, map_mul, lagLift_C,
    lagLift_X, lRedIdx]
