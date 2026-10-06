-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.dbar_mul
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.dbar_mul {a b : ℂ → ℂ} {z : ℂ} (ha : DifferentiableAt ℝ a z)
    (hb : DifferentiableAt ℝ b z) :
    dbar (fun w => a w * b w) z = dbar a z * b z + a z * dbar b z := by sorry
