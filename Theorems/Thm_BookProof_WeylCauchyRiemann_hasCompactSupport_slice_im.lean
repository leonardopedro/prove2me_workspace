-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.hasCompactSupport_slice_im
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.hasCompactSupport_slice_im {ψ : ℂ → ℂ} (hψc : HasCompactSupport ψ) (x : ℝ) :
    HasCompactSupport (fun t : ℝ => ψ ((x : ℂ) + t * Complex.I)) := by sorry
