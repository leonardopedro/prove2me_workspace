-- Generated from ChapterIrreversible.lean — solution of BookProof.ChapterIrreversible.entropy_nonneg
import Mathlib
import Definitions.Def_ChapterIrreversible
import Theorems.Thm_BookProof_ChapterIrreversible_le_one_of_prob
open BookProof.ChapterIrreversible



open scoped BigOperators
open Finset


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin n → ℝ) (hnn : ∀ a, 0 ≤ p a)
    (hsum : ∑ a, p a = 1) : 0 ≤ entropy p := by

  exact Finset.sum_nonneg fun i _ => Real.negMulLog_nonneg ( hnn i ) ( le_one_of_prob p hnn hsum i )
