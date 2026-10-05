-- Generated from ChapterLogPartitionConvex.lean — solution of BookProof.ChapterLogPartitionConvex.logPartition_isGreatest
import Mathlib
import Definitions.Def_ChapterLogPartitionConvex
import Theorems.Thm_BookProof_ChapterSoftmaxMaxEntropy_softmax_free_energy_eq
import Theorems.Thm_BookProof_ChapterSoftmaxMaxEntropy_softmax_free_energy_le
open BookProof.ChapterLogPartitionConvex



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    IsGreatest {x : ℝ | ∃ p : Fin m → ℝ, (∀ j, 0 ≤ p j) ∧ (∑ j, p j) = 1 ∧
        x = beta * (∑ j, p j * s j) + shannonEntropy p} (logPartition beta s) := by

  constructor
  · refine ⟨scoreSoftmax beta s, fun j => scoreSoftmax_nonneg beta s j,
      scoreSoftmax_sum_one beta s i, ?_⟩
    have := softmax_free_energy_eq beta s i
    linarith
  · rintro x ⟨p, hp0, hpsum, rfl⟩
    have := softmax_free_energy_le beta s i hp0 hpsum
    linarith
