-- Generated from ChapterSphericalPlancherel.lean — solution of BookProof.ChapterSphericalPlancherel.integral_eq_two_mul_of_even_real
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
open BookProof.ChapterSphericalPlancherel




open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

set_option maxHeartbeats 1000000 in
theorem solution (h : ℝ → ℝ) (he : ∀ x, h (-x) = h x) :
    ∫ x : ℝ, h x = 2 * ∫ x in Ioi (0 : ℝ), h x := by

  rw [← integral_comp_abs (f := h)]
  refine integral_congr_ae (Filter.Eventually.of_forall fun x => ?_)
  simp only
  rcases abs_cases x with ⟨h1, _⟩ | ⟨h1, _⟩
  · rw [h1]
  · rw [h1, he]
