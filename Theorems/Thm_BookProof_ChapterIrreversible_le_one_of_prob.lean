-- Generated from ChapterIrreversible.lean — theorem BookProof.ChapterIrreversible.le_one_of_prob
import Mathlib
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible


open scoped BigOperators
open Finset


variable {n : ℕ}


theorem BookProof.ChapterIrreversible.le_one_of_prob (p : Fin n → ℝ) (hnn : ∀ a, 0 ≤ p a)
    (hsum : ∑ a, p a = 1) (a : Fin n) : p a ≤ 1 := by sorry
