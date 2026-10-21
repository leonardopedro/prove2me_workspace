-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.unitaryU_neg_eq_star
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_unitaryU_add
import Theorems.Thm_BookProof_NonnegUnitaryGroup_unitaryU_surjective
import Theorems.Thm_BookProof_NonnegUnitaryGroup_unitaryU_mem_unitary
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
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (t : ℝ) :
    unitaryU hT hsv (-t) = star (unitaryU hT hsv t) := by

  have hone : unitaryU hT hsv (-t) * unitaryU hT hsv t = 1 := by
    rw [← unitaryU_add hT hsv]
    simp
  have hstar : star (unitaryU hT hsv t) * unitaryU hT hsv t = 1 :=
    (Unitary.mem_iff.mp (unitaryU_mem_unitary hT hsv t)).1
  have hsurj := unitaryU_surjective hT hsv t
  ext y
  obtain ⟨x, hx⟩ := hsurj y
  have h1 := congrArg (fun S : F →L[ℂ] F => S x) hone
  have h2 := congrArg (fun S : F →L[ℂ] F => S x) hstar
  simp only [ContinuousLinearMap.mul_apply, ContinuousLinearMap.one_apply] at h1 h2
  rw [← hx, h1, h2]
