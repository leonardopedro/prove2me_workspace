-- Generated from ChapterAttentionCollision.lean — theorem BookProof.ChapterAttentionCollision.renyi2_scoreSoftmax_le_shannonEntropy
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionCollision

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionCollision.renyi2_scoreSoftmax_le_shannonEntropy (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    renyi2 (scoreSoftmax beta s) ≤ shannonEntropy (scoreSoftmax beta s) := by sorry
