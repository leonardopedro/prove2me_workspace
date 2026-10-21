-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.eq_cfc_gFun
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_isUnit_den
import Theorems.Thm_BookProof_PositiveSquareRoot_cfc_gFun_mul_den
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]
variable {D : Submodule ℂ F}
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (C R : H →L[ℂ] H) (hC : 0 ≤ C)
    (hid : R * (1 - C - C + C * C + C * C) = C * C) : R = cfc gFun C := by

  have hcancel : R * (1 - C - C + C * C + C * C)
      = cfc gFun C * (1 - C - C + C * C + C * C) := by
    rw [hid, cfc_gFun_mul_den C hC]
  exact (isUnit_den C hC).mul_right_cancel hcancel
