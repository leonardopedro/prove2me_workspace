-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.norm_invCLMAt_le
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_apply
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}
variable {a : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) (h : F) :
    ‖invCLMAt hT ha h‖ ≤ a⁻¹ * ‖h‖ := by

  have hb := norm_invLin_le (isNonnegSelfAdjoint_invSmulRel hT ha) (((a : ℂ))⁻¹ • h)
  have hnorm : ‖((a : ℂ))⁻¹ • h‖ = a⁻¹ * ‖h‖ := by
    rw [norm_smul]
    simp [abs_of_pos ha]
  rw [invCLMAt_apply]
  calc ‖invCLM (isNonnegSelfAdjoint_invSmulRel hT ha) (((a : ℂ))⁻¹ • h)‖
      ≤ ‖((a : ℂ))⁻¹ • h‖ := hb
    _ = a⁻¹ * ‖h‖ := hnorm
