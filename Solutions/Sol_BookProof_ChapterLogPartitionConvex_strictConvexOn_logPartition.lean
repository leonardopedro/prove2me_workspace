-- Generated from ChapterLogPartitionConvex.lean — solution of BookProof.ChapterLogPartitionConvex.strictConvexOn_logPartition
import Mathlib
import Definitions.Def_ChapterLogPartitionConvex
import Theorems.Thm_BookProof_ChapterLogPartitionConvex_deriv_logPartition_eq
import Theorems.Thm_BookProof_ChapterLogPartitionConvex_differentiable_logPartition
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_deriv_meanScore
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_varScore_pos_of_ne
open BookProof.ChapterLogPartitionConvex



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {s : Fin m → ℝ} {a b : Fin m} (hab : s a ≠ s b) :
    StrictConvexOn ℝ Set.univ fun c : ℝ => logPartition c s := by

  refine StrictMono.strictConvexOn_univ_of_deriv
    (differentiable_logPartition s a).continuous ?_
  rw [deriv_logPartition_eq s a]
  refine strictMono_of_deriv_pos fun c => ?_
  rw [deriv_meanScore c s a]
  exact varScore_pos_of_ne hab
