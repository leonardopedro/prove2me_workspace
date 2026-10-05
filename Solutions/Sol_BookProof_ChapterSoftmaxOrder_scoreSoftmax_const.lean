-- Generated from ChapterSoftmaxOrder.lean — solution of BookProof.ChapterSoftmaxOrder.scoreSoftmax_const
import Mathlib
import Definitions.Def_ChapterSoftmaxOrder
open BookProof.ChapterSoftmaxOrder



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta c : ℝ) (j : Fin m) :
    scoreSoftmax beta (fun _ => c) j = 1 / m := by

  have hm : (m : ℝ) ≠ 0 := Nat.cast_ne_zero.2 (Fin.pos j).ne'
  simp only [scoreSoftmax, Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul]
  field_simp
