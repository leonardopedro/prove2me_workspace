-- Generated from ChapterSphericalPlancherel.lean — solution of BookProof.ChapterSphericalPlancherel.sineTransform_odd
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
open BookProof.ChapterSphericalPlancherel




open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution (G : ℝ → ℂ) (w : ℝ) :
    sineTransform G (-w) = -sineTransform G w := by

  rw [sineTransform, sineTransform, ← integral_neg]
  refine setIntegral_congr_fun measurableSet_Ioi fun x _ => ?_
  rw [show 2 * π * (x * -w) = -(2 * π * (x * w)) by ring, Real.sin_neg]
  push_cast; ring
