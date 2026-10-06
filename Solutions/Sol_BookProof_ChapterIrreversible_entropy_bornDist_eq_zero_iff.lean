-- Generated from ChapterIrreversible.lean — solution of BookProof.ChapterIrreversible.entropy_bornDist_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterIrreversible
import Theorems.Thm_BookProof_ChapterIrreversible_bornDist_nonneg
import Theorems.Thm_BookProof_ChapterIrreversible_bornDist_sum
import Theorems.Thm_BookProof_ChapterIrreversible_entropy_eq_zero_iff_pointMass
import Theorems.Thm_BookProof_ChapterIrreversible_isPointMass_bornDist_iff
open BookProof.ChapterIrreversible



open scoped BigOperators
open Finset


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin n → ℂ) (hv : ∑ a, ‖v a‖ ^ 2 = 1) :
    entropy (bornDist v) = 0 ↔ IsDeterministicColumn v :=
  (entropy_eq_zero_iff_pointMass (bornDist v) (bornDist_nonneg v)
      (bornDist_sum v hv)).trans (isPointMass_bornDist_iff v hv)
