-- Generated from ChapterWeylCauchyRiemann.lean — theorem BookProof.WeylCauchyRiemann.mollify_eq_convolution_left
import Definitions.Def_ChapterRadialMollifier
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann



open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

theorem BookProof.WeylCauchyRiemann.mollify_eq_convolution_left (F : ℂ → ℂ) (χ : ℂ → ℝ) :
    mollify F χ = χ ⋆[ContinuousLinearMap.lsmul ℝ ℝ, volume] F := by sorry
