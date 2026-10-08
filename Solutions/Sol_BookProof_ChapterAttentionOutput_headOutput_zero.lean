-- Generated from ChapterAttentionOutput.lean — solution of BookProof.ChapterAttentionOutput.headOutput_zero
import Mathlib
import Definitions.Def_ChapterAttentionOutput
import Theorems.Thm_BookProof_ChapterAttentionOutput_headOutput_eq_sum
import Theorems.Thm_BookProof_ChapterSoftmaxSharpness_scoreSoftmax_zero
open BookProof.ChapterAttentionOutput



open scoped BigOperators

open Filter Topology

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m n : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin m → ℝ) (v : Fin m → E) :
    headOutput 0 s v = ((m : ℝ))⁻¹ • ∑ j, v j := by

  rw [headOutput_eq_sum, Finset.smul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [scoreSoftmax_zero, one_div]
