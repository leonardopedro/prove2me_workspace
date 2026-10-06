-- Generated from ChapterE4.lean — solution of BookProof.ChapterE4.wave_eq_zero_of_lt
import Mathlib
import Definitions.Def_ChapterE4
import Theorems.Thm_BookProof_ChapterE4_wave_succ
open BookProof.ChapterE4



open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (θ : ℕ → ℝ) (s d i : ℕ) (h : i < s) : wave θ s d i = 0 := by

  induction d generalizing s i with
  | zero => ?_
  | succ d hd => ?_
  · exact Pi.single_eq_of_ne ( ne_of_lt h ) _;
  · rw [ wave_succ ];
    simp [ basisVec, h.ne, hd _ _ ( Nat.lt_succ_of_lt h ) ]
