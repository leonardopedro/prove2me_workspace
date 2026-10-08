-- Generated from ChapterAttentionMarkov.lean — theorem BookProof.ChapterAttentionMarkov.attentionMatrix_isStochastic
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMarkov


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionMarkov.attentionMatrix_isStochastic (beta : ℝ) (S : Fin m → Fin m → ℝ) :
    IsStochastic (attentionMatrix beta S) := by sorry
