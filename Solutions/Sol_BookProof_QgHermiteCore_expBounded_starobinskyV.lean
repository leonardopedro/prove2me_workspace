-- Generated from ChapterQgHermiteCore.lean — solution of BookProof.QgHermiteCore.expBounded_starobinskyV
import Mathlib
import Definitions.Def_ChapterQgHermiteCore
open BookProof.QgHermiteCore














open MeasureTheory Polynomial Filter Topology
open BookProof.HermiteCore BookProof.Starobinsky







variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (hM : 0 < M) :
    ExpBounded (starobinskyV M alpha) := by

  have hs : (0 : ℝ) ≤ Real.sqrt (2 / 3) := Real.sqrt_nonneg _
  refine ⟨4 * |M ^ 4 / (16 * alpha)|, 2 * (Real.sqrt (2 / 3) / M), by positivity, fun x => ?_⟩
  rw [Real.norm_eq_abs]
  have habsu : |-(Real.sqrt (2 / 3)) * x / M| = Real.sqrt (2 / 3) / M * |x| := by
    rw [abs_div, abs_mul, abs_neg, abs_of_pos hM, abs_of_nonneg hs]
    ring
  have hexp_le : Real.exp (-(Real.sqrt (2 / 3)) * x / M)
      ≤ Real.exp (Real.sqrt (2 / 3) / M * |x|) :=
    Real.exp_le_exp.mpr (by rw [← habsu]; exact le_abs_self _)
  have hone : (1 : ℝ) ≤ Real.exp (Real.sqrt (2 / 3) / M * |x|) :=
    Real.one_le_exp (by positivity)
  have hpos : 0 < Real.exp (-(Real.sqrt (2 / 3)) * x / M) := Real.exp_pos _
  have habs : |1 - Real.exp (-(Real.sqrt (2 / 3)) * x / M)|
      ≤ 2 * Real.exp (Real.sqrt (2 / 3) / M * |x|) := by
    rw [abs_le]
    constructor <;> linarith
  have hexp2 : (Real.exp (Real.sqrt (2 / 3) / M * |x|)) ^ 2
      = Real.exp (2 * (Real.sqrt (2 / 3) / M) * |x|) := by
    rw [sq, ← Real.exp_add]
    congr 1
    ring
  have hsq : (1 - Real.exp (-(Real.sqrt (2 / 3)) * x / M)) ^ 2
      ≤ 4 * Real.exp (2 * (Real.sqrt (2 / 3) / M) * |x|) := by
    nlinarith [mul_self_le_mul_self
        (abs_nonneg (1 - Real.exp (-(Real.sqrt (2 / 3)) * x / M))) habs,
      sq_abs (1 - Real.exp (-(Real.sqrt (2 / 3)) * x / M)), hexp2]
  have hV : |starobinskyV M alpha x|
      = |M ^ 4 / (16 * alpha)| * (1 - Real.exp (-(Real.sqrt (2 / 3)) * x / M)) ^ 2 := by
    rw [starobinskyV, abs_mul]
    congr 1
    exact abs_of_nonneg (sq_nonneg _)
  rw [hV]
  have hK : (0 : ℝ) ≤ |M ^ 4 / (16 * alpha)| := abs_nonneg _
  calc |M ^ 4 / (16 * alpha)| * (1 - Real.exp (-(Real.sqrt (2 / 3)) * x / M)) ^ 2
      ≤ |M ^ 4 / (16 * alpha)| * (4 * Real.exp (2 * (Real.sqrt (2 / 3) / M) * |x|)) :=
        mul_le_mul_of_nonneg_left hsq hK
    _ = 4 * |M ^ 4 / (16 * alpha)| * Real.exp (2 * (Real.sqrt (2 / 3) / M) * |x|) := by ring
