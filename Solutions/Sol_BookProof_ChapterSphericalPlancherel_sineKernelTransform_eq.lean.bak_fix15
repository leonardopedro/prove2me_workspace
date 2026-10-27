-- Generated from ChapterSphericalPlancherel.lean — solution of BookProof.ChapterSphericalPlancherel.sineKernelTransform_eq
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
open BookProof.ChapterSphericalPlancherel




open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution (G : ℝ → ℂ) (p : ℝ) :
    sineKernelTransform G p = sineTransform G ((2 * π)⁻¹ * p) := by

  rw [sineKernelTransform, sineTransform]
  refine setIntegral_congr_fun measurableSet_Ioi fun x _ => ?_
  congr 3
  field_simp
