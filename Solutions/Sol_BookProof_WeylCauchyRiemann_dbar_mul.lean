-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.dbar_mul
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {a b : ℂ → ℂ} {z : ℂ} (ha : DifferentiableAt ℝ a z)
    (hb : DifferentiableAt ℝ b z) :
    dbar (fun w => a w * b w) z = dbar a z * b z + a z * dbar b z := by

  have he : (fun w => a w * b w) = a * b := rfl
  simp only [dbar, he, fderiv_mul ha hb, ContinuousLinearMap.add_apply,
    ContinuousLinearMap.coe_smul', Pi.smul_apply, smul_eq_mul]
  ring
