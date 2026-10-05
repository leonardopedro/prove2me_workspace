-- Generated from ChapterSinusoidalPosition.lean — solution of BookProof.ChapterSinusoidalPosition.scoreSoftmax_sinusoidal_ge
import Mathlib
import Definitions.Def_ChapterSinusoidalPosition
import Theorems.Thm_BookProof_ChapterSinusoidalPosition_abs_peInner_le
import Theorems.Thm_BookProof_ChapterAttentionRetrieval_scoreSoftmax_ge_of_spread
open BookProof.ChapterSinusoidalPosition



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} {beta : ℝ} (hb : 0 ≤ beta) (w : Fin n → ℝ)
    (p : ℝ) (k : Fin m → ℝ) (j : Fin m) :
    Real.exp (-(beta * (2 * n))) / (m : ℝ)
      ≤ scoreSoftmax beta (fun l => peInner w p (k l)) j := by

  refine scoreSoftmax_ge_of_spread hb _ j fun l => ?_
  have h1 := abs_le.mp (abs_peInner_le w p (k l))
  have h2 := abs_le.mp (abs_peInner_le w p (k j))
  linarith [h1.2, h2.1]
