-- Generated from ChapterE2.lean — solution of BookProof.ChapterE2.bornProb_nonneg
import Mathlib
import Definitions.Def_ChapterE2
import Theorems.Thm_BookProof_ChapterE2_stick_nonneg
import Theorems.Thm_BookProof_ChapterE2_remainder_nonneg
open BookProof.ChapterE2



open scoped BigOperators
open Finset

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (n : ℕ) (i : Fin n) : 0 ≤ bornProb θ n i := by

  unfold bornProb
  split
  · exact stick_nonneg θ _
  · exact remainder_nonneg θ _
