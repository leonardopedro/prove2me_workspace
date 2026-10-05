-- Generated from ChapterAttentionCollision.lean — theorem BookProof.ChapterAttentionCollision.renyi2_scoreSoftmax_le_shannonEntropy
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionCollision

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionCollision.renyi2_scoreSoftmax_le_shannonEntropy (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    renyi2 (scoreSoftmax beta s) ≤ shannonEntropy (scoreSoftmax beta s) := by sorry
