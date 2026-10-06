-- Generated from ChapterDisplacedThermalOverlap.lean — theorem BookProof.ChapterDisplacedThermalOverlap.dtOverlap_eq
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
open BookProof.ChapterDisplacedThermalOverlap


noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

theorem BookProof.ChapterDisplacedThermalOverlap.dtOverlap_eq (nbar : ℝ≥0) (a b : ℝ) :
    dtOverlap nbar a b
      = Real.exp (-(a - b) ^ 2 / (4 * ((nbar : ℝ) + 1 / 2)))
        / Real.sqrt (4 * π * ((nbar : ℝ) + 1 / 2)) := by sorry
