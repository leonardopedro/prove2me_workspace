-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.WeakCauchyRiemannOn.congr_ae
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.WeakCauchyRiemannOn.congr_ae {f g : ℂ → ℂ} {U : Set ℂ}
    (hg : WeakCauchyRiemannOn g U) (hae : ∀ᵐ z : ℂ, z ∈ U → f z = g z) :
    WeakCauchyRiemannOn f U := by sorry
