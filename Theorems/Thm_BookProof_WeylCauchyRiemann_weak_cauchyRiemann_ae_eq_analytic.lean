-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.weak_cauchyRiemann_ae_eq_analytic
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.weak_cauchyRiemann_ae_eq_analytic {f : ℂ → ℂ} {U : Set ℂ} (hU : IsOpen U)
    (hf : LocallyIntegrableOn f U) (hCR : WeakCauchyRiemannOn f U) :
    ∃ g : ℂ → ℂ, AnalyticOn ℂ g U ∧ ∀ᵐ z : ℂ, z ∈ U → f z = g z := by sorry
