-- Generated from ChapterMarkovEntropy.lean — theorem BookProof.ChapterMarkovEntropy.permMatrix_doublyStochastic
import Mathlib
import Definitions.Def_ChapterMarkovEntropy
open BookProof.ChapterMarkovEntropy


open scoped BigOperators
open Finset


variable {n : ℕ}


theorem BookProof.ChapterMarkovEntropy.permMatrix_doublyStochastic (σ : Equiv.Perm (Fin n)) :
    IsDoublyStochastic (permMatrix σ) where
  nonneg j i := by sorry
