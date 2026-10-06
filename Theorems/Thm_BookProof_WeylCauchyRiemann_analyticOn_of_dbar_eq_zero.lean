-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.analyticOn_of_dbar_eq_zero
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.analyticOn_of_dbar_eq_zero {g : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s)
    (hg : ∀ z ∈ s, DifferentiableAt ℝ g z) (hdbar : ∀ z ∈ s, dbar g z = 0) :
    AnalyticOn ℂ g s := by sorry
