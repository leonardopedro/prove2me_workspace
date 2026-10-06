-- Generated from ChapterGaugeWeylResidual.lean — theorem BookProof.ChapterGaugeWeylResidual.weyl_surface_preserved_by_remnant
import Mathlib
import Definitions.Def_ChapterGaugeWeylResidual
open BookProof.ChapterGaugeWeylResidual

theorem BookProof.ChapterGaugeWeylResidual.weyl_surface_preserved_by_remnant (θ A0 : ℝ → ℝ → ℝ)
    (hθ : ∀ x, Differentiable ℝ (fun s => θ s x)) (hti : TimeIndependent θ)
    (hA0 : A0 = fun _ _ => 0) :
    gaugeA0 θ A0 = fun _ _ => 0 := by sorry
