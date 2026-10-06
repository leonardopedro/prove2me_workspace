-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.polarSymm_eq
import Mathlib
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (r θ : ℝ) :
    Complex.polarCoord.symm (r, θ) = (r : ℂ) * Complex.exp ((θ : ℂ) * Complex.I) := by

  rw [Complex.exp_mul_I]
  simp [Complex.polarCoord_symm_apply]
