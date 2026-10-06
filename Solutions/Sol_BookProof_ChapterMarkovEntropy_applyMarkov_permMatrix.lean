-- Generated from ChapterMarkovEntropy.lean — solution of BookProof.ChapterMarkovEntropy.applyMarkov_permMatrix
import Mathlib
import Definitions.Def_ChapterMarkovEntropy
open BookProof.ChapterMarkovEntropy



open scoped BigOperators
open Finset


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (σ : Equiv.Perm (Fin n)) (p : Fin n → ℝ) :
    applyMarkov (permMatrix σ) p = fun j => p (σ.symm j) := by

  funext j
  unfold applyMarkov permMatrix
  rw [Finset.sum_eq_single (σ.symm j)] <;> aesop
