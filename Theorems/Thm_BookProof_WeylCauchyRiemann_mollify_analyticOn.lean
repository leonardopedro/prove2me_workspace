-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.mollify_analyticOn
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.mollify_analyticOn {f : ℂ → ℂ} {U : Set ℂ}
    (hf : LocallyIntegrableOn f U) (hCR : WeakCauchyRiemannOn f U)
    {c : ℂ} {R r δ : ℝ} (hδ : 0 < δ) (hr : 0 < r) (hrR : r + δ ≤ R)
    (hKU : closedBall c R ⊆ U) {χ : ℂ → ℝ} (hχ : ContDiff ℝ ∞ χ)
    (hχc : HasCompactSupport χ) (hsupp : Function.support χ ⊆ ball (0 : ℂ) δ) :
    AnalyticOn ℂ (mollify ((closedBall c R).indicator f) χ) (ball c r) := by sorry
