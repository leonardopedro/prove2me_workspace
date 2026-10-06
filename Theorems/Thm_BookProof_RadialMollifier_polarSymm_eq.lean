-- Generated from ChapterRadialMollifier.lean — theorem BookProof.RadialMollifier.polarSymm_eq
import Mathlib
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier



open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

theorem BookProof.RadialMollifier.polarSymm_eq (r θ : ℝ) :
    Complex.polarCoord.symm (r, θ) = (r : ℂ) * Complex.exp ((θ : ℂ) * Complex.I) := by sorry
