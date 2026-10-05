-- Generated from ChapterF4.lean — solution of BookProof.ChapterF4.csketch_smul
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4



open scoped BigOperators Matrix

variable {d k : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (h : Fin d → Fin k) (ω : Fin d → Bool) (a : ℝ) (x : Fin d → ℝ) :
    csketch h ω (a • x) = a • csketch h ω x := by

  unfold csketch;
  ext j; simp [ mul_left_comm, Finset.mul_sum _ _ _ ] ;
