-- Generated from ChapterLogPartitionConvex.lean — theorem BookProof.ChapterLogPartitionConvex.deriv_logPartition_eq
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterLogPartitionConvex
open BookProof.ChapterLogPartitionConvex

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterLogPartitionConvex.deriv_logPartition_eq (s : Fin m → ℝ) (i : Fin m) :
    (deriv fun b : ℝ => logPartition b s) = fun b : ℝ => meanScore b s := by sorry
