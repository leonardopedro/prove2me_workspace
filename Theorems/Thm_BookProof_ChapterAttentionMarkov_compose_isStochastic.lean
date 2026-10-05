-- Generated from ChapterAttentionMarkov.lean — theorem BookProof.ChapterAttentionMarkov.compose_isStochastic
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMarkov

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMarkov.compose_isStochastic {P Q : Fin m → Fin m → ℝ} (hP : IsStochastic P)
    (hQ : IsStochastic Q) : IsStochastic (compose P Q) := by sorry
