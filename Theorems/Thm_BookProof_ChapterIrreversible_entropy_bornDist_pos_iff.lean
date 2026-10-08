-- Generated from ChapterIrreversible.lean — theorem BookProof.ChapterIrreversible.entropy_bornDist_pos_iff
import Mathlib
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible


open scoped BigOperators
open Finset


variable {n : ℕ}


theorem BookProof.ChapterIrreversible.entropy_bornDist_pos_iff (v : Fin n → ℂ) (hv : ∑ a, ‖v a‖ ^ 2 = 1) :
    0 < entropy (bornDist v) ↔ ¬ IsDeterministicColumn v := by sorry
