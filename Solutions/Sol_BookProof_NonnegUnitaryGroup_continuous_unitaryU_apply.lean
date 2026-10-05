-- Generated from ChapterNonnegUnitaryGroup.lean — solution of BookProof.NonnegUnitaryGroup.continuous_unitaryU_apply
import Mathlib
import Definitions.Def_ChapterNonnegUnitaryGroup
import Theorems.Thm_BookProof_NonnegUnitaryGroup_unitaryU_apply_unitaryU
import Theorems.Thm_BookProof_NonnegUnitaryGroup_tendsto_unitaryU_zero
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
    (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0) (x : F) :
    Continuous (fun t : ℝ => unitaryU hT hsv t x) := by

  refine continuous_iff_continuousAt.mpr (fun t₀ => ?_)
  have h1 : Tendsto (fun t : ℝ => t - t₀) (𝓝 t₀) (𝓝 0) := by
    simpa using (continuous_sub_right t₀).tendsto t₀
  have h2 : Tendsto (fun t : ℝ => unitaryU hT hsv (t - t₀) x) (𝓝 t₀) (𝓝 x) :=
    (tendsto_unitaryU_zero hT hsv x).comp h1
  have h3 : Tendsto (fun t : ℝ => unitaryU hT hsv t₀ (unitaryU hT hsv (t - t₀) x)) (𝓝 t₀)
      (𝓝 (unitaryU hT hsv t₀ x)) :=
    ((unitaryU hT hsv t₀).continuous.tendsto x).comp h2
  have heq : (fun t : ℝ => unitaryU hT hsv t₀ (unitaryU hT hsv (t - t₀) x))
      = fun t : ℝ => unitaryU hT hsv t x := by
    funext t
    rw [unitaryU_apply_unitaryU]
    have hts : t₀ + (t - t₀) = t := by ring
    rw [hts]
  rw [heq] at h3
  exact h3
