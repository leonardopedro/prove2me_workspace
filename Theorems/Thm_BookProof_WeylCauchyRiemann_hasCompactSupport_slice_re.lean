-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.hasCompactSupport_slice_re
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.hasCompactSupport_slice_re {ψ : ℂ → ℂ} (hψc : HasCompactSupport ψ) (y : ℝ) :
    HasCompactSupport (fun t : ℝ => ψ ((t : ℂ) + y * Complex.I)) := by sorry
