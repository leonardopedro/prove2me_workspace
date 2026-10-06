-- Generated from ChapterIrreversible.lean — theorem BookProof.ChapterIrreversible.entropy_nonneg
import Mathlib
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible

variable {n : ℕ}


open scoped BigOperators
open Finset



theorem BookProof.ChapterIrreversible.entropy_nonneg (p : Fin n → ℝ) (hnn : ∀ a, 0 ≤ p a)
    (hsum : ∑ a, p a = 1) : 0 ≤ entropy p := by sorry
