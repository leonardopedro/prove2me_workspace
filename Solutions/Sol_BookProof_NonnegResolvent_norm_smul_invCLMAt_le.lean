-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.norm_smul_invCLMAt_le
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegSquareRoot_norm_invCLMAt_le
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (h : F) :
    ‖(a : ℂ) • invCLMAt hT ha h‖ ≤ ‖h‖ := by

  have hb := norm_invCLMAt_le hT ha h
  rw [norm_smul]
  have hnorm : ‖(a : ℂ)‖ = a := by
    simp [abs_of_pos ha]
  rw [hnorm]
  calc a * ‖invCLMAt hT ha h‖ ≤ a * (a⁻¹ * ‖h‖) := by
        exact mul_le_mul_of_nonneg_left hb ha.le
    _ = ‖h‖ := by
        field_simp
