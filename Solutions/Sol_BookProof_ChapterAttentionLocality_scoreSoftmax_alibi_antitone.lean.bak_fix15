-- Generated from ChapterAttentionLocality.lean — solution of BookProof.ChapterAttentionLocality.scoreSoftmax_alibi_antitone
import Mathlib
import Definitions.Def_ChapterAttentionLocality
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_denom_pos
open BookProof.ChapterAttentionLocality



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution {beta gamma : ℝ} (hb : 0 ≤ beta) (hg : 0 ≤ gamma)
    (c : ℝ) (d : Fin m → ℝ) {i j : Fin m} (hij : d i ≤ d j) :
    scoreSoftmax beta (alibiScore (fun _ => c) gamma d) j
      ≤ scoreSoftmax beta (alibiScore (fun _ => c) gamma d) i := by

  rw [scoreSoftmax, scoreSoftmax]
  refine div_le_div_of_nonneg_right ?_ (scoreSoftmax_denom_pos beta _ i).le
  refine Real.exp_le_exp.2 (mul_le_mul_of_nonneg_left ?_ hb)
  have : gamma * d i ≤ gamma * d j := mul_le_mul_of_nonneg_left hij hg
  simp only [alibiScore]
  linarith
