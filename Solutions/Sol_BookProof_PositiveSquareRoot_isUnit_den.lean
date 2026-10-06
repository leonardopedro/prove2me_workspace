-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.isUnit_den
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_den_pos
import Theorems.Thm_BookProof_PositiveSquareRoot_continuous_den
import Theorems.Thm_BookProof_PositiveSquareRoot_cfc_den
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
theorem solution (C : H →L[ℂ] H) (hC : 0 ≤ C) :
    IsUnit (1 - C - C + C * C + C * C : H →L[ℂ] H) := by

  have hsa : IsSelfAdjoint C := hC.isSelfAdjoint
  rw [← cfc_den C hC,
    isUnit_cfc_iff (R := ℝ) (fun t : ℝ => 1 - t - t + t * t + t * t) C
      continuous_den.continuousOn hsa]
  intro t _
  exact ne_of_gt (den_pos t)
