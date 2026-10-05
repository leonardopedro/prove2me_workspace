-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.unitaryU_apply_unitaryU
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_unitaryU_add
open BookProof.NonnegUnitaryGroup




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open BookProof.NonnegResolvent
open Filter Topology NormedSpace
open scoped InnerProductSpace

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {B C : F →L[ℂ] F} {s t : ℝ}
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (s t : ℝ) (x : F) :
    unitaryU hT hsv s (unitaryU hT hsv t x) = unitaryU hT hsv (s + t) x := by

  rw [unitaryU_add hT hsv]; rfl
