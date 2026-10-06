-- Generated from ChapterMarkovEntropy.lean — solution of BookProof.ChapterMarkovEntropy.entropy_applyMarkov_permMatrix
import Mathlib
import Definitions.Def_ChapterMarkovEntropy
import Theorems.Thm_BookProof_ChapterMarkovEntropy_applyMarkov_permMatrix
open BookProof.ChapterMarkovEntropy



open scoped BigOperators
open Finset


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (σ : Equiv.Perm (Fin n)) (p : Fin n → ℝ) :
    entropy (applyMarkov (permMatrix σ) p) = entropy p := by

  rw [applyMarkov_permMatrix]
  exact Equiv.sum_comp σ.symm (fun j => Real.negMulLog (p j))
