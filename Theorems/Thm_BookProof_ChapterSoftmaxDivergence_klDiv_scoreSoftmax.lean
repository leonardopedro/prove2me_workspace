-- Generated from ChapterSoftmaxDivergence.lean — theorem BookProof.ChapterSoftmaxDivergence.klDiv_scoreSoftmax
import Definitions.Def_ChapterAttentionEntropy
import Mathlib
import Definitions.Def_ChapterSoftmaxDivergence
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxDivergence

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterSoftmaxDivergence.klDiv_scoreSoftmax (beta gamma : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    klDiv (scoreSoftmax beta s) (scoreSoftmax gamma s)
      = logPartition gamma s - logPartition beta s
          - (gamma - beta) * meanScore beta s := by sorry
