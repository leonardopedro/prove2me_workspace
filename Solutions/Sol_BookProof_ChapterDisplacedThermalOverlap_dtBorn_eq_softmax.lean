-- Generated from ChapterDisplacedThermalOverlap.lean — solution of BookProof.ChapterDisplacedThermalOverlap.dtBorn_eq_softmax
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
import Theorems.Thm_BookProof_ChapterDisplacedThermalOverlap_dtOverlap_eq
open BookProof.ChapterDisplacedThermalOverlap



noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

set_option maxHeartbeats 1000000 in
theorem solution {m : ℕ} (nbar : ℝ≥0) (q : ℝ) (k : Fin m → ℝ) (j : Fin m) :
    dtBorn nbar q k j
      = BookProof.ChapterSoftmaxSharpness.scoreSoftmax (inverseTemperature nbar)
          (fun l => -(q - k l) ^ 2) j := by

  have hc : (0 : ℝ) < Real.sqrt (4 * π * ((nbar : ℝ) + 1 / 2)) :=
    Real.sqrt_pos.mpr (by positivity)
  have hval : ∀ l : Fin m, dtOverlap nbar q (k l)
      = (Real.sqrt (4 * π * ((nbar : ℝ) + 1 / 2)))⁻¹
        * Real.exp (inverseTemperature nbar * (-(q - k l) ^ 2)) := by
    intro l
    rw [dtOverlap_eq, inverseTemperature, div_eq_inv_mul]
    congr 2
    field_simp
  simp only [dtBorn, BookProof.ChapterSoftmaxSharpness.scoreSoftmax, hval]
  rw [← Finset.mul_sum]
  rw [mul_div_mul_left _ _ (by positivity)]
