-- Generated from ChapterIrreversible.lean — theorem BookProof.ChapterIrreversible.exists_mem_Ioo_of_not_pointMass
import Mathlib
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible

variable {n : ℕ}


open scoped BigOperators
open Finset



theorem BookProof.ChapterIrreversible.exists_mem_Ioo_of_not_pointMass (p : Fin n → ℝ) (hnn : ∀ a, 0 ≤ p a)
    (hsum : ∑ a, p a = 1) (hnp : ¬ IsPointMass p) :
    ∃ a, 0 < p a ∧ p a < 1 := by sorry
