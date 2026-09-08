-- Generated from ChapterNavierStokesEsa.lean — solution of BookProof.NavierStokesFlow.hasZeroDeficiencyOn_of_bounded_symmetric
import Mathlib
import Definitions.Def_ChapterNavierStokesEsa
import Theorems.Thm_BookProof_NavierStokesFlow_eq_zero_of_inner_left_eq_zero_on_dense
open BookProof.NavierStokesFlow









open scoped Matrix



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (A : F →L[ℂ] F)
    (hsym : (A : F →ₗ[ℂ] F).IsSymmetric) (D : Submodule ℂ F) (hdense : Dense (D : Set F))
    (hinv : ∀ v : D, A (v : F) ∈ D) :
    HasZeroDeficiencyOn D
      (LinearMap.codRestrict D ((A : F →ₗ[ℂ] F).comp D.subtype) fun v => hinv v) := by

  have key : ∀ (c : ℂ) (w : F), (∀ v : D, (inner ℂ (A (v : F)) w : ℂ) = inner ℂ (v : F) (c • w)) →
      A w = c • w := by
    intro c w hw
    refine sub_eq_zero.mp (eq_zero_of_inner_left_eq_zero_on_dense hdense (A w - c • w) fun v => ?_)
    have hs := hsym (v : F) w
    simp only [ContinuousLinearMap.coe_coe] at hs
    rw [inner_sub_right, ← hw v, ← hs]
    ring
  constructor
  · intro w hw
    exact (symmetric_hasZeroDeficiency (A : F →ₗ[ℂ] F) hsym).1 w (key Complex.I w hw)
  · intro w hw
    refine (symmetric_hasZeroDeficiency (A : F →ₗ[ℂ] F) hsym).2 w ?_
    have := key (-Complex.I) w (by simpa using hw)
    simpa using this
