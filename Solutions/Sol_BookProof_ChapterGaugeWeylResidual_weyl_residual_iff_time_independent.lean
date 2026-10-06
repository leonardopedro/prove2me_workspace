-- Generated from ChapterGaugeWeylResidual.lean — solution of BookProof.ChapterGaugeWeylResidual.weyl_residual_iff_time_independent
import Mathlib
import Definitions.Def_ChapterGaugeWeylResidual
open BookProof.ChapterGaugeWeylResidual

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℝ → ℝ → ℝ)
    (hθ : ∀ x, Differentiable ℝ (fun s => θ s x)) :
    (∀ t x, dt θ t x = 0) ↔ TimeIndependent θ := by

  constructor
  · intro h t s x
    exact is_const_of_deriv_eq_zero (hθ x) (fun u => h u x) t s
  · intro h t x
    have : (fun s => θ s x) = fun _ => θ t x := funext fun s => h s t x
    simp [dt, this]
