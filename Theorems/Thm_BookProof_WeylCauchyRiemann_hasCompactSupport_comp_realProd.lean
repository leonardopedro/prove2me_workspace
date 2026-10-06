-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.hasCompactSupport_comp_realProd
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.hasCompactSupport_comp_realProd {F : ℂ → ℂ} (hF : HasCompactSupport F) :
    HasCompactSupport (fun p : ℝ × ℝ => F ((p.1 : ℂ) + p.2 * Complex.I)) := by sorry
