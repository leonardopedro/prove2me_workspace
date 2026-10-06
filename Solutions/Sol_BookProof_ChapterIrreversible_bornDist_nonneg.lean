-- Generated from ChapterIrreversible.lean — solution of BookProof.ChapterIrreversible.bornDist_nonneg
import Mathlib
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible



open scoped BigOperators
open Finset


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin n → ℂ) (a : Fin n) : 0 ≤ bornDist v a := by

  exact sq_nonneg _
