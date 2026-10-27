-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.mollify_eq_convolution_right
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
import Theorems.Thm_BookProof_WeylCauchyRiemann_mollify_eq_convolution_left
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (F : ℂ → ℂ) (χ : ℂ → ℝ) :
    mollify F χ = F ⋆[(ContinuousLinearMap.lsmul ℝ ℝ).flip, volume] χ := by

  rw [mollify_eq_convolution_left, convolution_flip]
