-- Generated from ChapterSternGerlach.lean — solution of BookProof.ChapterSternGerlach.normSq_exp_mul_I
import Mathlib
import Definitions.Def_ChapterSternGerlach
open BookProof.ChapterSternGerlach




open Complex Matrix Finset

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℝ) :
    Complex.normSq (Complex.exp ((θ : ℂ) * Complex.I)) = 1 := by

  rw [Complex.exp_mul_I, ← Complex.ofReal_cos, ← Complex.ofReal_sin,
    Complex.normSq_add_mul_I]
  exact Real.cos_sq_add_sin_sq θ
