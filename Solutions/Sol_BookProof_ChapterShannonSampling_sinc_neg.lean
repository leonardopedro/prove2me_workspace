-- Generated from ChapterShannonSampling.lean — solution of BookProof.ChapterShannonSampling.sinc_neg
import Mathlib
import Definitions.Def_ChapterShannonSampling
open BookProof.ChapterShannonSampling




open MeasureTheory Complex AddCircle intervalIntegral Set
open scoped Real ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (u : ℝ) : sinc (-u) = sinc u := by

  rcases eq_or_ne u 0 with rfl | hu
  · simp
  · rw [sinc, sinc, if_neg (by simpa using hu), if_neg hu, mul_neg, Real.sin_neg]
    field_simp
