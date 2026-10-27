-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.contDiff_slice_im
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) : ContDiff ℝ ∞ (fun t : ℝ => (x : ℂ) + t * Complex.I) := by

  exact contDiff_const.add ((Complex.ofRealCLM.contDiff).mul contDiff_const)
