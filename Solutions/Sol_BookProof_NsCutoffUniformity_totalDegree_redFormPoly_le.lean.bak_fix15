-- Generated from ChapterNsCutoffUniformity.lean — solution of BookProof.NsCutoffUniformity.totalDegree_redFormPoly_le
import Mathlib
import Definitions.Def_ChapterNsCutoffUniformity
open BookProof.NsCutoffUniformity




open MvPolynomial BookProof.NsFullEuler

noncomputable section

variable {n : ℕ}

variable {n : ℕ}
variable {ι : Type*}
variable (nu : ℝ) (k : Fin 3 → ℝ)
private theorem totalDegree_C_mul_X_le (c : ℂ) (a : Fin (n * 6)) :
    (C c * X a : MvPolynomial (Fin (n * 6)) ℂ).totalDegree ≤ 2 := by
  refine (totalDegree_mul _ _).trans ?_
  rw [totalDegree_C, totalDegree_X]
  norm_num
private theorem totalDegree_C_mul_X_mul_X_le (c : ℂ) (a b : Fin (n * 6)) :
    (C c * (X a * X b) : MvPolynomial (Fin (n * 6)) ℂ).totalDegree ≤ 2 := by
  refine (totalDegree_mul _ _).trans ?_
  have hab : (X a * X b : MvPolynomial (Fin (n * 6)) ℂ).totalDegree ≤ 2 := by
    refine (totalDegree_mul _ _).trans ?_
    rw [totalDegree_X, totalDegree_X]
  rw [totalDegree_C]
  simpa using hab

set_option maxHeartbeats 1000000 in
theorem solution (p : Fin n) (r : Fin 7) :
    (redFormPoly nu k n p r).totalDegree ≤ 2 := by

  rw [redFormPoly]
  split
  · refine (totalDegree_add _ _).trans ?_
    refine max_le ?_ (totalDegree_C_mul_X_le _ _)
    rw [totalDegree_X]
    norm_num
  · split
    · refine (totalDegree_finset_sum _ _).trans (Finset.sup_le fun j _ => ?_)
      exact totalDegree_C_mul_X_mul_X_le _ _ _
    · refine (totalDegree_finset_sum _ _).trans (Finset.sup_le fun j _ => ?_)
      exact totalDegree_C_mul_X_le _ _
