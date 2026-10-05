-- Generated from ChapterLogPartitionConvex.lean — theorem BookProof.ChapterLogPartitionConvex.differentiable_logPartition
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterLogPartitionConvex
open BookProof.ChapterLogPartitionConvex

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterLogPartitionConvex.differentiable_logPartition (s : Fin m → ℝ) (i : Fin m) :
    Differentiable ℝ fun b : ℝ => logPartition b s := by sorry
