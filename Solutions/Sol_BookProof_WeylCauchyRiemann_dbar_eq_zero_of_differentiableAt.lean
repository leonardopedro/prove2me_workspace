-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.dbar_eq_zero_of_differentiableAt
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {g : ℂ → ℂ} {z : ℂ} (h : DifferentiableAt ℂ g z) :
    dbar g z = 0 := by

  have hr := (h.hasDerivAt.hasFDerivAt).restrictScalars ℝ
  simp only [dbar, hr.fderiv, ContinuousLinearMap.coe_restrictScalars',
    ContinuousLinearMap.toSpanSingleton_apply, smul_eq_mul]
  linear_combination (deriv g z) * Complex.I_sq
