-- Generated from ChapterSoftmaxDivergence.lean — theorem BookProof.ChapterSoftmaxDivergence.logPartition_tangent_le
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


theorem BookProof.ChapterSoftmaxDivergence.logPartition_tangent_le (beta gamma : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    logPartition beta s + (gamma - beta) * meanScore beta s ≤ logPartition gamma s := by sorry
