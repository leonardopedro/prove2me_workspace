-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.integral_complex_eq_prod
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.integral_complex_eq_prod (G : ℂ → ℂ) :
    ∫ z : ℂ, G z = ∫ p : ℝ × ℝ, G (p.1 + p.2 * Complex.I) := by sorry
