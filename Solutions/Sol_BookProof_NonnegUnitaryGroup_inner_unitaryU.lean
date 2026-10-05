-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.inner_unitaryU
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_norm_unitaryU_apply
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
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (t : ℝ) (x y : F) :
    ⟪unitaryU hT hsv t x, unitaryU hT hsv t y⟫_ℂ = ⟪x, y⟫_ℂ := by

  have hn : ∀ z : F, ‖(unitaryU hT hsv t : F →ₗ[ℂ] F) z‖ = ‖z‖ :=
    fun z => norm_unitaryU_apply hT hsv t z
  exact (LinearIsometry.mk (unitaryU hT hsv t : F →ₗ[ℂ] F) hn).inner_map_map x y
