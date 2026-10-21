-- Generated from ChapterLogPartitionConvex.lean — solution of BookProof.ChapterLogPartitionConvex.convexOn_logPartition
import Mathlib
import Definitions.Def_ChapterLogPartitionConvex
import Theorems.Thm_BookProof_ChapterLogPartitionConvex_deriv_logPartition_eq
import Theorems.Thm_BookProof_ChapterLogPartitionConvex_differentiable_logPartition
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_meanScore_monotone
open BookProof.ChapterLogPartitionConvex



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin m → ℝ) (i : Fin m) :
    ConvexOn ℝ Set.univ fun b : ℝ => logPartition b s := by

  refine Monotone.convexOn_univ_of_deriv (differentiable_logPartition s i) ?_
  rw [deriv_logPartition_eq s i]
  exact meanScore_monotone s i
