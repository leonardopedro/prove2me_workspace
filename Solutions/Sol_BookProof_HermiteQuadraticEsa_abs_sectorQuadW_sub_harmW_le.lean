-- Generated from ChapterHermiteQuadraticEsa.lean — solution of BookProof.HermiteQuadraticEsa.abs_sectorQuadW_sub_harmW_le
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
import Theorems.Thm_BookProof_HermiteQuadraticEsa_norm_sq_two
import Theorems.Thm_BookProof_HermiteQuadraticEsa_abs_coord_zero_le_norm_two
open BookProof.HermiteQuadraticEsa















open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha mu : ℝ) (x : Vd 2) :
    |sectorQuadW M alpha mu x - harmW x|
      ≤ max |alpha - 1 / 4| |mu - 1 / 4| * ‖x‖ ^ 2 + (M ^ 2 / 2) * ‖x‖ + 0 := by

  have hsq := norm_sq_two x
  have hc0 := abs_coord_zero_le_norm_two x
  have hharm : harmW x = ‖x‖ ^ 2 / 4 := rfl
  have hsplit : sectorQuadW M alpha mu x - harmW x
      = (alpha - 1 / 4) * (x 0) ^ 2 + (mu - 1 / 4) * (x 1) ^ 2 - (M ^ 2 / 2) * (x 0) := by
    unfold sectorQuadW confV
    rw [hharm, hsq]
    ring
  have hmax0 : |alpha - 1 / 4| ≤ max |alpha - 1 / 4| |mu - 1 / 4| := le_max_left _ _
  have hmax1 : |mu - 1 / 4| ≤ max |alpha - 1 / 4| |mu - 1 / 4| := le_max_right _ _
  have t1 := abs_sub ((alpha - 1 / 4) * (x 0) ^ 2 + (mu - 1 / 4) * (x 1) ^ 2)
    ((M ^ 2 / 2) * (x 0))
  have t2 := abs_add_le ((alpha - 1 / 4) * (x 0) ^ 2) ((mu - 1 / 4) * (x 1) ^ 2)
  have e0 : |(alpha - 1 / 4) * (x 0) ^ 2| = |alpha - 1 / 4| * (x 0) ^ 2 := by
    rw [abs_mul, abs_of_nonneg (sq_nonneg (x 0))]
  have e1 : |(mu - 1 / 4) * (x 1) ^ 2| = |mu - 1 / 4| * (x 1) ^ 2 := by
    rw [abs_mul, abs_of_nonneg (sq_nonneg (x 1))]
  have e2 : |(M ^ 2 / 2) * (x 0)| ≤ (M ^ 2 / 2) * ‖x‖ := by
    rw [abs_mul, abs_of_nonneg (by positivity : (0 : ℝ) ≤ M ^ 2 / 2)]
    exact mul_le_mul_of_nonneg_left hc0 (by positivity)
  have b0 : |alpha - 1 / 4| * (x 0) ^ 2 ≤ max |alpha - 1 / 4| |mu - 1 / 4| * (x 0) ^ 2 :=
    mul_le_mul_of_nonneg_right hmax0 (sq_nonneg _)
  have b1 : |mu - 1 / 4| * (x 1) ^ 2 ≤ max |alpha - 1 / 4| |mu - 1 / 4| * (x 1) ^ 2 :=
    mul_le_mul_of_nonneg_right hmax1 (sq_nonneg _)
  have hAsum : max |alpha - 1 / 4| |mu - 1 / 4| * ‖x‖ ^ 2
      = max |alpha - 1 / 4| |mu - 1 / 4| * (x 0) ^ 2
        + max |alpha - 1 / 4| |mu - 1 / 4| * (x 1) ^ 2 := by
    rw [hsq]; ring
  rw [hsplit]
  linarith
