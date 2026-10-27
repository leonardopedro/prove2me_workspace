-- Generated from ChapterSoftmaxJacobian.lean — solution of BookProof.ChapterSoftmaxJacobian.softmaxJacobian_posSemidef
import Mathlib
import Definitions.Def_ChapterSoftmaxJacobian
import Theorems.Thm_BookProof_ChapterSoftmaxJacobian_weightedVar_nonneg
import Theorems.Thm_BookProof_ChapterSoftmaxJacobian_softmaxJacobian_quadratic_form
open BookProof.ChapterSoftmaxJacobian



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {beta : ℝ} (hb : 0 ≤ beta) (s x : Fin m → ℝ) (i : Fin m) :
    0 ≤ ∑ i, ∑ j, x i * softmaxJacobian beta s i j * x j := by

  rw [softmaxJacobian_quadratic_form]
  exact mul_nonneg hb (weightedVar_nonneg beta s x i)
