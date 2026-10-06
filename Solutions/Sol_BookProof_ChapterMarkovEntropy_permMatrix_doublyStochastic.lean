-- Generated from ChapterMarkovEntropy.lean — solution of BookProof.ChapterMarkovEntropy.permMatrix_doublyStochastic
import Mathlib
import Definitions.Def_ChapterMarkovEntropy
open BookProof.ChapterMarkovEntropy



open scoped BigOperators
open Finset


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (σ : Equiv.Perm (Fin n)) :
    IsDoublyStochastic (permMatrix σ) where
  nonneg j i :=
  where
    nonneg j i := by unfold permMatrix; split_ifs <;> norm_num
    colSum i := by simp [permMatrix]
    rowSum j := by
      unfold permMatrix
      rw [Finset.sum_eq_single (σ.symm j)]
      · simp
      · intro b _ hb
        rw [if_neg]
        intro h
        exact hb (by rw [h, Equiv.symm_apply_apply])
      · intro h; exact absurd (Finset.mem_univ _) h
