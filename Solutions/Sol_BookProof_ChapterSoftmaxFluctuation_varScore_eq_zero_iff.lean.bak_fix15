-- Generated from ChapterSoftmaxFluctuation.lean — solution of BookProof.ChapterSoftmaxFluctuation.varScore_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterSoftmaxFluctuation
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_nonneg
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_pos
open BookProof.ChapterSoftmaxFluctuation



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) :
    varScore beta s = 0 ↔ ∀ l, s l = meanScore beta s := by

  constructor
  · intro h l
    have hterm : ∀ j ∈ (Finset.univ : Finset (Fin m)),
        scoreSoftmax beta s j * (s j - meanScore beta s) ^ 2 = 0 :=
      (Finset.sum_eq_zero_iff_of_nonneg fun j _ =>
        mul_nonneg (scoreSoftmax_nonneg beta s j) (sq_nonneg _)).1 h
    have := hterm l (Finset.mem_univ l)
    rcases mul_eq_zero.1 this with hp | hsq
    · exact absurd hp (ne_of_gt (scoreSoftmax_pos beta s l))
    · have : s l - meanScore beta s = 0 := by
        simpa using pow_eq_zero_iff (n := 2) two_ne_zero |>.1 hsq
      linarith
  · intro h
    refine Finset.sum_eq_zero fun l _ => ?_
    rw [h l, sub_self]
    simp
