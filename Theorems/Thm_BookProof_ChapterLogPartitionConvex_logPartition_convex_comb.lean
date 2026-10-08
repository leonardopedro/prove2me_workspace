-- Generated from ChapterLogPartitionConvex.lean — theorem BookProof.ChapterLogPartitionConvex.logPartition_convex_comb
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterLogPartitionConvex
import Definitions.Def_ChapterSoftmaxFluctuation
open BookProof.ChapterLogPartitionConvex


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxFluctuation

variable {m : ℕ}


theorem BookProof.ChapterLogPartitionConvex.logPartition_convex_comb (s : Fin m → ℝ) (i : Fin m) (b c t u : ℝ)
    (ht : 0 ≤ t) (hu : 0 ≤ u) (htu : t + u = 1) :
    logPartition (t * b + u * c) s ≤ t * logPartition b s + u * logPartition c s := by sorry
