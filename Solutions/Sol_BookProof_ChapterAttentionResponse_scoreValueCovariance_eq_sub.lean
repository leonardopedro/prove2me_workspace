-- Generated from ChapterAttentionResponse.lean — solution of BookProof.ChapterAttentionResponse.scoreValueCovariance_eq_sub
import Mathlib
import Definitions.Def_ChapterAttentionResponse
import Theorems.Thm_BookProof_ChapterAttentionOutput_headOutput_eq_sum
open BookProof.ChapterAttentionResponse



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (v : Fin m → E) :
    scoreValueCovariance beta s v
      = (∑ j, (scoreSoftmax beta s j * s j) • v j) - meanScore beta s • headOutput beta s v := by

  rw [scoreValueCovariance, headOutput_eq_sum, Finset.smul_sum, ← Finset.sum_sub_distrib]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [smul_smul, ← sub_smul]
  ring_nf
