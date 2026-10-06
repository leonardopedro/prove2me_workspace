-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.integral_deriv_eq_zero_of_hasCompactSupport
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.integral_deriv_eq_zero_of_hasCompactSupport {u : ℝ → ℂ} (hu : ContDiff ℝ 1 u)
    (huc : HasCompactSupport u) : ∫ t : ℝ, deriv u t = 0 := by sorry
