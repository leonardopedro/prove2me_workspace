-- Generated from ChapterAttentionMarkov.lean — theorem BookProof.ChapterAttentionMarkov.attentionMatrix_pos
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMarkov


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionMarkov.attentionMatrix_pos (beta : ℝ) (S : Fin m → Fin m → ℝ) (i j : Fin m) :
    0 < attentionMatrix beta S i j := by sorry
