-- Generated from ChapterAttentionMasking.lean — solution of BookProof.ChapterAttentionMasking.maskedSoftmax_univ
import Mathlib
import Definitions.Def_ChapterAttentionMasking
import Definitions.Def_ChapterSoftmaxOrder
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterAttentionMasking



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    maskedSoftmax beta s Finset.univ j = scoreSoftmax beta s j := by

  rw [maskedSoftmax, if_pos (Finset.mem_univ j), scoreSoftmax]
