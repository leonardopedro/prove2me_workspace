-- Generated from ChapterAttentionMarkov.lean — theorem BookProof.ChapterAttentionMarkov.attentionMatrix_isStochastic
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMarkov

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMarkov.attentionMatrix_isStochastic (beta : ℝ) (S : Fin m → Fin m → ℝ) :
    IsStochastic (attentionMatrix beta S) := by sorry
