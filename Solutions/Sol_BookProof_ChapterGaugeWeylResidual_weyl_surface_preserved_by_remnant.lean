-- Generated from ChapterGaugeWeylResidual.lean — solution of BookProof.ChapterGaugeWeylResidual.weyl_surface_preserved_by_remnant
import Mathlib
import Definitions.Def_ChapterGaugeWeylResidual
import Theorems.Thm_BookProof_ChapterGaugeWeylResidual_weyl_residual_iff_time_independent
open BookProof.ChapterGaugeWeylResidual

set_option maxHeartbeats 1000000 in
theorem solution (θ A0 : ℝ → ℝ → ℝ)
    (hθ : ∀ x, Differentiable ℝ (fun s => θ s x)) (hti : TimeIndependent θ)
    (hA0 : A0 = fun _ _ => 0) :
    gaugeA0 θ A0 = fun _ _ => 0 := by

  have h := (weyl_residual_iff_time_independent θ hθ).mpr hti
  funext t x
  simp [gaugeA0, hA0, h t x]
