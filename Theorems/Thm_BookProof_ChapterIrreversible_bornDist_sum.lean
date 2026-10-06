-- Generated from ChapterIrreversible.lean — theorem BookProof.ChapterIrreversible.bornDist_sum
import Mathlib
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible

variable {n : ℕ}


open scoped BigOperators
open Finset



theorem BookProof.ChapterIrreversible.bornDist_sum (v : Fin n → ℂ) (hv : ∑ a, ‖v a‖ ^ 2 = 1) :
    ∑ a, bornDist v a = 1 := by sorry
