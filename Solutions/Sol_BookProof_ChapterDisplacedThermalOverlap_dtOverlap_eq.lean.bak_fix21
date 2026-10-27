-- Generated from ChapterDisplacedThermalOverlap.lean — solution of BookProof.ChapterDisplacedThermalOverlap.dtOverlap_eq
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
import Theorems.Thm_BookProof_ChapterDisplacedThermalOverlap_tauNN_ne_zero
import Theorems.Thm_BookProof_ChapterDisplacedThermalOverlap_gaussianPDFReal_mul_gaussianPDFReal
open BookProof.ChapterDisplacedThermalOverlap



noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

set_option maxHeartbeats 1000000 in
theorem solution (nbar : ℝ≥0) (a b : ℝ) :
    dtOverlap nbar a b
      = Real.exp (-(a - b) ^ 2 / (4 * ((nbar : ℝ) + 1 / 2)))
        / Real.sqrt (4 * π * ((nbar : ℝ) + 1 / 2)) := by

  have hv : tauNN nbar ≠ 0 := tauNN_ne_zero nbar
  have hhalf : (tauNN nbar / 2 : ℝ≥0) ≠ 0 := by
    simpa using hv
  simp only [dtOverlap]
  rw [integral_congr_ae (Filter.Eventually.of_forall
    (fun x => gaussianPDFReal_mul_gaussianPDFReal a b hv x))]
  rw [MeasureTheory.integral_const_mul, integral_gaussianPDFReal_eq_one _ hhalf, mul_one,
    tauNN_coe]
