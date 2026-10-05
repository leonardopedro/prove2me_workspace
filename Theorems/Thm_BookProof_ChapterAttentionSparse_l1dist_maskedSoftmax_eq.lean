-- Generated from ChapterAttentionSparse.lean — theorem BookProof.ChapterAttentionSparse.l1dist_maskedSoftmax_eq
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionSparse
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionSparse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionSparse.l1dist_maskedSoftmax_eq (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    (hS : S.Nonempty) (i : Fin m) :
    l1dist (maskedSoftmax beta s S) (scoreSoftmax beta s)
      = 2 * (1 - attendedMass beta s S) := by sorry
