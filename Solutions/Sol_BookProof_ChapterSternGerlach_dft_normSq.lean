-- Generated from ChapterSternGerlach.lean — solution of BookProof.ChapterSternGerlach.dft_normSq
import Mathlib
import Definitions.Def_ChapterSternGerlach
import Theorems.Thm_BookProof_ChapterSternGerlach_normSq_exp_mul_I
open BookProof.ChapterSternGerlach




open Complex Matrix Finset

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) (hn : 0 < n) (i j : Fin n) :
    Complex.normSq (dftMatrix n i j) = 1 / n := by

  unfold dftMatrix
  rw [map_div₀]
  have hexp : (2 * (Real.pi : ℂ) * Complex.I * (i.val * j.val) / n)
      = ((2 * Real.pi * (i.val * j.val) / n : ℝ) : ℂ) * Complex.I := by
    push_cast; ring
  rw [hexp, normSq_exp_mul_I]
  have hsqrt : Complex.normSq (Real.sqrt n : ℂ) = n := by
    rw [Complex.normSq_ofReal, Real.mul_self_sqrt (by positivity)]
  rw [hsqrt]
