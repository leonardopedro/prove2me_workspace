-- Generated from ChapterSoftmaxJacobian.lean — solution of BookProof.ChapterSoftmaxJacobian.softmaxJacobian_diag_nonneg
import Mathlib
import Definitions.Def_ChapterSoftmaxJacobian
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_le_one
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_pos
open BookProof.ChapterSoftmaxJacobian



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ) (i : Fin m) :
    0 ≤ softmaxJacobian beta s i i := by

  have h1 : scoreSoftmax beta s i ≤ 1 := scoreSoftmax_le_one beta s i
  have h2 : 0 ≤ scoreSoftmax beta s i := le_of_lt (scoreSoftmax_pos beta s i)
  have : 0 ≤ (1 : ℝ) - scoreSoftmax beta s i := by linarith
  simpa [softmaxJacobian] using mul_nonneg (mul_nonneg hb h2) this
