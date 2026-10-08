-- Generated from ChapterAttentionMarkov.lean — theorem BookProof.ChapterAttentionMarkov.push_compose
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMarkov
open BookProof.ChapterAttentionMarkov


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionMarkov.push_compose (P Q : Fin m → Fin m → ℝ) (p : Fin m → ℝ) (j : Fin m) :
    push (compose P Q) p j = push Q (push P p) j := by sorry
