-- Generated from ChapterLogPartitionConvex.lean — solution of BookProof.ChapterLogPartitionConvex.logPartition_convex_comb
import Mathlib
import Definitions.Def_ChapterLogPartitionConvex
import Theorems.Thm_BookProof_ChapterLogPartitionConvex_convexOn_logPartition
open BookProof.ChapterLogPartitionConvex



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin m → ℝ) (i : Fin m) (b c t u : ℝ)
    (ht : 0 ≤ t) (hu : 0 ≤ u) (htu : t + u = 1) :
    logPartition (t * b + u * c) s ≤ t * logPartition b s + u * logPartition c s := (convexOn_logPartition s i).2 (Set.mem_univ b) (Set.mem_univ c) ht hu htu
