-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.exists_analyticOn_ae_eq_ball
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.exists_analyticOn_ae_eq_ball {f : ℂ → ℂ} {U : Set ℂ}
    (hf : LocallyIntegrableOn f U) (hCR : WeakCauchyRiemannOn f U)
    {c : ℂ} {R : ℝ} (hR : 0 < R) (hKU : closedBall c R ⊆ U) :
    ∃ g : ℂ → ℂ, AnalyticOn ℂ g (ball c (R / 4)) ∧
      ∀ᵐ z : ℂ, z ∈ ball c (R / 4) → f z = g z := by sorry
