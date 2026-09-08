-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.abs_confW_sub_harmW_le
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_norm_sq_one
import Theorems.Thm_BookProof_HermiteQuadraticEsa_abs_coord_le_norm
open BookProof.HermiteQuadraticEsa















open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (x : Vd 1) :
    |confW M alpha x - harmW x| ≤ |alpha - 1 / 4| * ‖x‖ ^ 2 + (M ^ 2 / 2) * ‖x‖ + 0 := by

  have hsq := norm_sq_one x
  have habs := abs_coord_le_norm x
  have hharm : harmW x = ‖x‖ ^ 2 / 4 := rfl
  have hsplit : confW M alpha x - harmW x
      = (alpha - 1 / 4) * (x 0) ^ 2 - (M ^ 2 / 2) * (x 0) := by
    unfold confW confV
    rw [hharm, hsq]
    ring
  rw [hsplit]
  have h1 : |(alpha - 1 / 4) * (x 0) ^ 2 - (M ^ 2 / 2) * (x 0)|
      ≤ |(alpha - 1 / 4) * (x 0) ^ 2| + |(M ^ 2 / 2) * (x 0)| := abs_sub _ _
  have h2 : |(alpha - 1 / 4) * (x 0) ^ 2| = |alpha - 1 / 4| * ‖x‖ ^ 2 := by
    rw [abs_mul, abs_of_nonneg (sq_nonneg (x 0)), hsq]
  have h3 : |(M ^ 2 / 2) * (x 0)| ≤ (M ^ 2 / 2) * ‖x‖ := by
    rw [abs_mul, abs_of_nonneg (by positivity : (0 : ℝ) ≤ M ^ 2 / 2)]
    exact mul_le_mul_of_nonneg_left habs (by positivity)
  linarith
