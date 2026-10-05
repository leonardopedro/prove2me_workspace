-- Generated from ChapterSoftmaxJacobian.lean — solution of BookProof.ChapterSoftmaxJacobian.hasDerivAt_scoreSoftmax_score
import Mathlib
import Definitions.Def_ChapterSoftmaxJacobian
import Theorems.Thm_BookProof_ChapterSoftmaxJacobian_hasDerivAt_exp_score
import Theorems.Thm_BookProof_ChapterSoftmaxJacobian_hasDerivAt_partition_score
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_partition_ne_zero
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_partition_pos
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_scoreSoftmax_eq_div
open BookProof.ChapterSoftmaxJacobian



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i j : Fin m) :
    HasDerivAt (fun t : ℝ => scoreSoftmax beta (scorePerturb s i t) j)
      (softmaxJacobian beta s i j) 0 := by

  have hne := partition_ne_zero beta s i
  have hZ := hasDerivAt_partition_score beta s i
  have hnum : HasDerivAt (fun t : ℝ => Real.exp (beta * scorePerturb s i t j))
      ((if j = i then beta else 0) * Real.exp (beta * s j)) 0 := by
    by_cases hj : j = i
    · subst hj
      simpa [scorePerturb] using hasDerivAt_exp_score beta 0 (s j)
    · simpa [scorePerturb, hj] using (hasDerivAt_const (0 : ℝ) (Real.exp (beta * s j)))
  have h := hnum.div hZ (by simpa using hne)
  have hgoal : (fun t : ℝ => scoreSoftmax beta (scorePerturb s i t) j)
      = fun t : ℝ =>
        Real.exp (beta * scorePerturb s i t j) / partition beta (scorePerturb s i t) := by
    funext t
    rw [scoreSoftmax_eq_div]
  rw [hgoal]
  refine h.congr_deriv ?_
  have hP : (0 : ℝ) < partition beta s := partition_pos beta s i
  rw [softmaxJacobian, scoreSoftmax_eq_div, scoreSoftmax_eq_div]
  simp only [scorePerturb_zero]
  rcases eq_or_ne j i with hj | hj
  · subst hj
    rw [if_pos (rfl : j = j), if_pos (rfl : j = j)]
    field_simp
  · rw [if_neg hj, if_neg hj]
    field_simp
    ring
