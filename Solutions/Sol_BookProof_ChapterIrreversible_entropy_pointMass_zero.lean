-- Generated from ChapterIrreversible.lean — solution of BookProof.ChapterIrreversible.entropy_pointMass_zero
import Mathlib
import Definitions.Def_ChapterIrreversible
open BookProof.ChapterIrreversible



open scoped BigOperators
open Finset


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin n → ℝ) (hp : IsPointMass p) :
    entropy p = 0 := by

  obtain ⟨ a, ha ⟩ := hp;
  exact Finset.sum_eq_zero fun i hi => by by_cases hi' : i = a <;> simp [ * ] ;
