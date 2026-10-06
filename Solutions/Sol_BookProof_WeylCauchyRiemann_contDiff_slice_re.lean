-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.contDiff_slice_re
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) : ContDiff ℝ ∞ (fun t : ℝ => (t : ℂ) + y * Complex.I) := by

  exact (Complex.ofRealCLM.contDiff).add contDiff_const
