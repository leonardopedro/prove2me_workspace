-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.unitaryU_mem_unitary
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_norm_unitaryU_apply
import Theorems.Thm_BookProof_NonnegUnitaryGroup_unitaryU_surjective
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
    unitaryU hT hsv t ∈ unitary (F →L[ℂ] F) := by

  have hiso : ∀ x y : F, ⟪unitaryU hT hsv t x, unitaryU hT hsv t y⟫_ℂ = ⟪x, y⟫_ℂ := by
    intro x y
    have hn : ∀ z : F, ‖(unitaryU hT hsv t : F →ₗ[ℂ] F) z‖ = ‖z‖ :=
      fun z => norm_unitaryU_apply hT hsv t z
    exact (LinearIsometry.mk (unitaryU hT hsv t : F →ₗ[ℂ] F) hn).inner_map_map x y
  have hstar : star (unitaryU hT hsv t) * unitaryU hT hsv t = 1 := by
    ext x
    have : ContinuousLinearMap.adjoint (unitaryU hT hsv t) (unitaryU hT hsv t x) = x := by
      refine ext_inner_right ℂ ?_
      intro y
      rw [ContinuousLinearMap.adjoint_inner_left, hiso]
    simpa [ContinuousLinearMap.star_eq_adjoint] using this
  refine Unitary.mem_iff.mpr ⟨hstar, ?_⟩
  ext y
  obtain ⟨x, hx⟩ := unitaryU_surjective hT hsv t y
  have hxx : (star (unitaryU hT hsv t)) (unitaryU hT hsv t x) = x := by
    have h := congrArg (fun (S : F →L[ℂ] F) => S x) hstar
    simpa using h
  rw [← hx]
  simp only [ContinuousLinearMap.mul_apply, ContinuousLinearMap.one_apply, hxx]
