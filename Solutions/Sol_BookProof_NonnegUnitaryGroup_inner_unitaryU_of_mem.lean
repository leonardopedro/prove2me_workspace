-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.inner_unitaryU_of_mem
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_mem_unitaryU
import Theorems.Thm_BookProof_NonnegUnitaryGroup_inner_unitaryU
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
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) {h k : F} (hk : (h, k) ∈ T) (t : ℝ) :
    (unitaryU hT hsv t h, unitaryU hT hsv t k) ∈ T ∧
      ⟪unitaryU hT hsv t h, unitaryU hT hsv t k⟫_ℂ = ⟪h, k⟫_ℂ := ⟨mem_unitaryU hT hsv hk t, inner_unitaryU hT hsv t h k⟩
