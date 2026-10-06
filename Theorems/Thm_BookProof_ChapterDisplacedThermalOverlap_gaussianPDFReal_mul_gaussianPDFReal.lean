-- Generated from ChapterDisplacedThermalOverlap.lean — theorem BookProof.ChapterDisplacedThermalOverlap.gaussianPDFReal_mul_gaussianPDFReal
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
open BookProof.ChapterDisplacedThermalOverlap


noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

theorem BookProof.ChapterDisplacedThermalOverlap.gaussianPDFReal_mul_gaussianPDFReal (a b : ℝ) {v : ℝ≥0} (hv : v ≠ 0) (x : ℝ) :
    gaussianPDFReal a v x * gaussianPDFReal b v x
      = (Real.exp (-(a - b) ^ 2 / (4 * (v : ℝ))) / Real.sqrt (4 * π * v))
        * gaussianPDFReal ((a + b) / 2) (v / 2) x := by sorry
