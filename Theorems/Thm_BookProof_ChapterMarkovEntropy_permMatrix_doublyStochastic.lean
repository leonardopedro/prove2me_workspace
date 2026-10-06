-- Generated from ChapterMarkovEntropy.lean — theorem BookProof.ChapterMarkovEntropy.permMatrix_doublyStochastic
import Mathlib
import Definitions.Def_ChapterMarkovEntropy
open BookProof.ChapterMarkovEntropy

variable {n : ℕ}


open scoped BigOperators
open Finset



theorem BookProof.ChapterMarkovEntropy.permMatrix_doublyStochastic (σ : Equiv.Perm (Fin n)) :
    IsDoublyStochastic (permMatrix σ) where
  nonneg j i := by sorry
