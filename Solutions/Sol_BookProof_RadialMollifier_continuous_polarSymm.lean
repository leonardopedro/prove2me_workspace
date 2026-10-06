-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.continuous_polarSymm
import Mathlib
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Continuous (fun p : ℝ × ℝ => Complex.polarCoord.symm p) := by

  simp only [Complex.polarCoord_symm_apply]
  fun_prop
