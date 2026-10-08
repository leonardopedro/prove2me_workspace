-- Generated from ChapterIrreversible.lean — theorem BookProof.ChapterIrreversible.isPointMass_bornDist_iff
import Mathlib
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible


open scoped BigOperators
open Finset


variable {n : ℕ}


theorem BookProof.ChapterIrreversible.isPointMass_bornDist_iff (v : Fin n → ℂ) (hv : ∑ a, ‖v a‖ ^ 2 = 1) :
    IsPointMass (bornDist v) ↔ IsDeterministicColumn v := by sorry
