-- Generated from ChapterAttentionMarkov.lean — theorem BookProof.ChapterAttentionMarkov.attentionMatrix_pos
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMarkov

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMarkov.attentionMatrix_pos (beta : ℝ) (S : Fin m → Fin m → ℝ) (i j : Fin m) :
    0 < attentionMatrix beta S i j := by sorry
