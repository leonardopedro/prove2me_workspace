-- Generated from ChapterGaugeWeylResidual.lean — theorem BookProof.ChapterGaugeWeylResidual.remnant_moves_every_configuration
import Mathlib
import Definitions.Def_ChapterGaugeWeylResidual
open BookProof.ChapterGaugeWeylResidual

theorem BookProof.ChapterGaugeWeylResidual.remnant_moves_every_configuration :
    ∃ θ : ℝ → ℝ → ℝ, TimeIndependent θ ∧ (∀ t x, dt θ t x = 0) ∧
      (∀ t x, dx θ t x = 1) ∧ ∀ A1 : ℝ → ℝ → ℝ, gaugeA1 θ A1 ≠ A1 := by sorry
