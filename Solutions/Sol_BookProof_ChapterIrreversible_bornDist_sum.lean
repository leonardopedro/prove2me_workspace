-- Generated from ChapterIrreversible.lean — solution of BookProof.ChapterIrreversible.bornDist_sum
import Mathlib
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible



open scoped BigOperators
open Finset


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin n → ℂ) (hv : ∑ a, ‖v a‖ ^ 2 = 1) :
    ∑ a, bornDist v a = 1 := by

  exact hv
