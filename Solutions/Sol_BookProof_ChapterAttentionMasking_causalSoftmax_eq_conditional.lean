-- Generated from ChapterAttentionMasking.lean — solution of BookProof.ChapterAttentionMasking.causalSoftmax_eq_conditional
import Mathlib
import Definitions.Def_ChapterAttentionMasking
import Theorems.Thm_BookProof_ChapterAttentionMasking_maskedSoftmax_eq_conditional
import Theorems.Thm_BookProof_ChapterAttentionMasking_mem_causalMask
open BookProof.ChapterAttentionMasking



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) {i j : Fin m} (hij : j ≤ i) :
    maskedSoftmax beta s (causalMask m i) j
      = scoreSoftmax beta s j / ∑ l ∈ causalMask m i, scoreSoftmax beta s l := maskedSoftmax_eq_conditional beta s (mem_causalMask.2 hij)
