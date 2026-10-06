-- Generated from ChapterMarkovEntropy.lean — theorem BookProof.ChapterMarkovEntropy.applyMarkov_permMatrix
import Mathlib
import Definitions.Def_ChapterMarkovEntropy
open BookProof.ChapterMarkovEntropy

variable {n : ℕ}


open scoped BigOperators
open Finset



theorem BookProof.ChapterMarkovEntropy.applyMarkov_permMatrix (σ : Equiv.Perm (Fin n)) (p : Fin n → ℝ) :
    applyMarkov (permMatrix σ) p = fun j => p (σ.symm j) := by sorry
