-- Generated from ChapterLogPartitionConvex.lean — theorem BookProof.ChapterLogPartitionConvex.logPartition_isGreatest
import Definitions.Def_ChapterAttentionEntropy
import Mathlib
import Definitions.Def_ChapterLogPartitionConvex
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterLogPartitionConvex

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterLogPartitionConvex.logPartition_isGreatest (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    IsGreatest {x : ℝ | ∃ p : Fin m → ℝ, (∀ j, 0 ≤ p j) ∧ (∑ j, p j) = 1 ∧
        x = beta * (∑ j, p j * s j) + shannonEntropy p} (logPartition beta s) := by sorry
