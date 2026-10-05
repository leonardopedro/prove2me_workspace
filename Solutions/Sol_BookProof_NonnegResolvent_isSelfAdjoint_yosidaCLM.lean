-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.isSelfAdjoint_yosidaCLM
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_NonnegResolvent_inner_invCLMAt_left
import Theorems.Thm_BookProof_NonnegResolvent_yosidaCLM_apply
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) :
    IsSelfAdjoint (yosidaCLM hT ha) := by

  rw [ContinuousLinearMap.isSelfAdjoint_iff_isSymmetric]
  intro x y
  change (inner ℂ (yosidaCLM hT ha x) y : ℂ) = inner ℂ x (yosidaCLM hT ha y)
  simp only [yosidaCLM_apply, inner_smul_left, inner_smul_right, inner_sub_left, inner_sub_right,
    Complex.conj_ofReal]
  rw [inner_invCLMAt_left hT ha x y]
