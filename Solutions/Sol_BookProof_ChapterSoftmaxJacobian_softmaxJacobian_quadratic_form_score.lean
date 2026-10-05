-- Generated from ChapterSoftmaxJacobian.lean — solution of BookProof.ChapterSoftmaxJacobian.softmaxJacobian_quadratic_form_score
import Mathlib
import Definitions.Def_ChapterSoftmaxJacobian
import Theorems.Thm_BookProof_ChapterSoftmaxJacobian_softmaxJacobian_quadratic_form
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_varScore_eq_sub_sq
open BookProof.ChapterSoftmaxJacobian



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    ∑ a, ∑ b, s a * softmaxJacobian beta s a b * s b = beta * varScore beta s := by

  rw [softmaxJacobian_quadratic_form]
  simp only [weightedVar, varScore_eq_sub_sq beta s i, meanScore]
