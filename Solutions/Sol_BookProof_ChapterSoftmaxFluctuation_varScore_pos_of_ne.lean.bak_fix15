-- Generated from ChapterSoftmaxFluctuation.lean — solution of BookProof.ChapterSoftmaxFluctuation.varScore_pos_of_ne
import Mathlib
import Definitions.Def_ChapterSoftmaxFluctuation
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_varScore_nonneg
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_varScore_eq_zero_iff
open BookProof.ChapterSoftmaxFluctuation



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {beta : ℝ} {s : Fin m → ℝ} {a b : Fin m} (hab : s a ≠ s b) :
    0 < varScore beta s := by

  rcases lt_or_eq_of_le (varScore_nonneg beta s) with h | h
  · exact h
  · exfalso
    have hall := (varScore_eq_zero_iff beta s).1 h.symm
    exact hab ((hall a).trans (hall b).symm)
