-- Generated from ChapterSoftmaxFluctuation.lean — solution of BookProof.ChapterSoftmaxFluctuation.varScore_eq_zero_of_const
import Mathlib
import Definitions.Def_ChapterSoftmaxFluctuation
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_varScore_eq_zero_iff
open BookProof.ChapterSoftmaxFluctuation



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {s : Fin m → ℝ} {c : ℝ} (hs : ∀ l, s l = c)
    (beta : ℝ) (i : Fin m) : varScore beta s = 0 := by

  refine (varScore_eq_zero_iff beta s).2 fun l => ?_
  have hmean : meanScore beta s = c := by
    rw [meanScore, Finset.sum_congr rfl fun j _ => by rw [hs j], ← Finset.sum_mul,
      scoreSoftmax_sum_one beta s i, one_mul]
  rw [hs l, hmean]
