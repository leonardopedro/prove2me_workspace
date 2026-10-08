-- Generated from ChapterMarkovEntropy.lean — theorem BookProof.ChapterMarkovEntropy.applyMarkov_permMatrix
import Mathlib
import Definitions.Def_ChapterMarkovEntropy
open BookProof.ChapterMarkovEntropy


open scoped BigOperators
open Finset


variable {n : ℕ}


theorem BookProof.ChapterMarkovEntropy.applyMarkov_permMatrix (σ : Equiv.Perm (Fin n)) (p : Fin n → ℝ) :
    applyMarkov (permMatrix σ) p = fun j => p (σ.symm j) := by sorry
