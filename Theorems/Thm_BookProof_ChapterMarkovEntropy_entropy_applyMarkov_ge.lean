-- Generated from ChapterMarkovEntropy.lean — theorem BookProof.ChapterMarkovEntropy.entropy_applyMarkov_ge
import Mathlib
import Definitions.Def_ChapterMarkovEntropy
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible
open BookProof.ChapterMarkovEntropy


open scoped BigOperators
open Finset


variable {n : ℕ}


theorem BookProof.ChapterMarkovEntropy.entropy_applyMarkov_ge (M : Fin n → Fin n → ℝ) (hM : IsDoublyStochastic M)
    (p : Fin n → ℝ) (hp : ∀ i, 0 ≤ p i) :
    entropy p ≤ entropy (applyMarkov M p) := by sorry
