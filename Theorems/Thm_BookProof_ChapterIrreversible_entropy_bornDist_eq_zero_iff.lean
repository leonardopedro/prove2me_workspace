-- Generated from ChapterIrreversible.lean — theorem BookProof.ChapterIrreversible.entropy_bornDist_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible


open scoped BigOperators
open Finset


variable {n : ℕ}


theorem BookProof.ChapterIrreversible.entropy_bornDist_eq_zero_iff (v : Fin n → ℂ) (hv : ∑ a, ‖v a‖ ^ 2 = 1) :
    entropy (bornDist v) = 0 ↔ IsDeterministicColumn v := by sorry
