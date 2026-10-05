-- Generated from ChapterAttentionMarkov.lean — solution of BookProof.ChapterAttentionMarkov.attentionMatrix_pos
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMarkov



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (S : Fin m → Fin m → ℝ) (i j : Fin m) :
    0 < attentionMatrix beta S i j := scoreSoftmax_pos beta (S i) j
