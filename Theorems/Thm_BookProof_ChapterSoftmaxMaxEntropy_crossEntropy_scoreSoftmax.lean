-- Generated from ChapterSoftmaxMaxEntropy.lean — theorem BookProof.ChapterSoftmaxMaxEntropy.crossEntropy_scoreSoftmax
import Definitions.Def_ChapterAttentionEntropy
import Mathlib
import Definitions.Def_ChapterSoftmaxMaxEntropy
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxMaxEntropy

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterSoftmaxMaxEntropy.crossEntropy_scoreSoftmax (beta : ℝ) (s : Fin m → ℝ) {p : Fin m → ℝ}
    (hpsum : ∑ j, p j = 1) :
    crossEntropy p (scoreSoftmax beta s) = logPartition beta s - beta * ∑ j, p j * s j := by sorry
