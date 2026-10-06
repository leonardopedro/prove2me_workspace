-- Generated from ChapterGaugeWeylResidual.lean — theorem BookProof.ChapterGaugeWeylResidual.weyl_residual_iff_time_independent
import Mathlib
import Definitions.Def_ChapterGaugeWeylResidual
open BookProof.ChapterGaugeWeylResidual

theorem BookProof.ChapterGaugeWeylResidual.weyl_residual_iff_time_independent (θ : ℝ → ℝ → ℝ)
    (hθ : ∀ x, Differentiable ℝ (fun s => θ s x)) :
    (∀ t x, dt θ t x = 0) ↔ TimeIndependent θ := by sorry
