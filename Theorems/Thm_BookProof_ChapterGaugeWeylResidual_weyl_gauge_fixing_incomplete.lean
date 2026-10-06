-- Generated from ChapterGaugeWeylResidual.lean — theorem BookProof.ChapterGaugeWeylResidual.weyl_gauge_fixing_incomplete
import Mathlib
import Definitions.Def_ChapterGaugeWeylResidual
open BookProof.ChapterGaugeWeylResidual

theorem BookProof.ChapterGaugeWeylResidual.weyl_gauge_fixing_incomplete :
    ∃ (θ : ℝ → ℝ → ℝ) (A1 : ℝ → ℝ → ℝ),
      TimeIndependent θ ∧ (∀ t x, dt θ t x = 0) ∧
        gaugeA0 θ (fun _ _ => 0) = (fun _ _ => 0) ∧ gaugeA1 θ A1 ≠ A1 := by sorry
