-- Generated from ChapterNumericalRangeSemigroup.lean — solution of BookProof.ChapterNumericalRangeSemigroup.norm_cexp_le_of_re_le
import Mathlib
import Definitions.Def_ChapterNumericalRangeSemigroup
open BookProof.ChapterNumericalRangeSemigroup



open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {ω t : ℝ} (ht : 0 ≤ t) {z : ℂ} (hz : z.re ≤ ω) :
    ‖Complex.exp ((t : ℂ) * z)‖ ≤ Real.exp (ω * t) := by

  rw [Complex.norm_exp]
  have : ((t : ℂ) * z).re = t * z.re := by simp
  rw [this]
  exact Real.exp_le_exp.mpr (by nlinarith)
