-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.expBounded_confW
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_expBounded_of_le_harm
import Theorems.Thm_BookProof_HermiteQuadraticEsa_abs_confW_sub_harmW_le
open BookProof.HermiteQuadraticEsa















open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) : ExpBounded (confW M alpha) := by

  refine expBounded_of_le_harm (a := 4 * |alpha - 1 / 4| + 1 + M ^ 2 / 2)
    (b := M ^ 2 / 2) (by positivity) (by positivity) fun x => ?_
  have h := abs_confW_sub_harmW_le M alpha x
  have hharm : harmW x = ‖x‖ ^ 2 / 4 := rfl
  have hlin : (M ^ 2 / 2) * ‖x‖ ≤ (M ^ 2 / 2) * (‖x‖ ^ 2 / 4 + 1) := by
    have : ‖x‖ ≤ ‖x‖ ^ 2 / 4 + 1 := by nlinarith [sq_nonneg (‖x‖ - 2)]
    exact mul_le_mul_of_nonneg_left this (by positivity)
  have habs : |confW M alpha x| ≤ |confW M alpha x - harmW x| + |harmW x| := by
    have hsplit : confW M alpha x = (confW M alpha x - harmW x) + harmW x := by ring
    calc |confW M alpha x| = |(confW M alpha x - harmW x) + harmW x| := by rw [← hsplit]
      _ ≤ |confW M alpha x - harmW x| + |harmW x| := abs_add_le _ _
  have hharm0 : |harmW x| = ‖x‖ ^ 2 / 4 := by
    rw [hharm, abs_of_nonneg (by positivity : (0 : ℝ) ≤ ‖x‖ ^ 2 / 4)]
  rw [hharm]
  rw [hharm0] at habs
  nlinarith [norm_nonneg x, abs_nonneg (alpha - 1 / 4)]
