-- Generated from ChapterIrreversible.lean — solution of BookProof.ChapterIrreversible.le_one_of_prob
import Mathlib
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible



open scoped BigOperators
open Finset


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin n → ℝ) (hnn : ∀ a, 0 ≤ p a)
    (hsum : ∑ a, p a = 1) (a : Fin n) : p a ≤ 1 := by

  exact hsum ▸ Finset.single_le_sum ( fun a _ => hnn a ) ( Finset.mem_univ a )
