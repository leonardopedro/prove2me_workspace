-- Generated from ChapterMarkovEntropy.lean — theorem BookProof.ChapterMarkovEntropy.entropy_applyMarkov_permMatrix
import Mathlib
import Definitions.Def_ChapterMarkovEntropy
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible
open BookProof.ChapterMarkovEntropy

variable {n : ℕ}


open scoped BigOperators
open Finset



theorem BookProof.ChapterMarkovEntropy.entropy_applyMarkov_permMatrix (σ : Equiv.Perm (Fin n)) (p : Fin n → ℝ) :
    entropy (applyMarkov (permMatrix σ) p) = entropy p := by sorry
