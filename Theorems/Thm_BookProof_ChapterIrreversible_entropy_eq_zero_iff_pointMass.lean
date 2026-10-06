-- Generated from ChapterIrreversible.lean — theorem BookProof.ChapterIrreversible.entropy_eq_zero_iff_pointMass
import Mathlib
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible

variable {n : ℕ}


open scoped BigOperators
open Finset



theorem BookProof.ChapterIrreversible.entropy_eq_zero_iff_pointMass (p : Fin n → ℝ) (hnn : ∀ a, 0 ≤ p a)
    (hsum : ∑ a, p a = 1) : entropy p = 0 ↔ IsPointMass p := by sorry
