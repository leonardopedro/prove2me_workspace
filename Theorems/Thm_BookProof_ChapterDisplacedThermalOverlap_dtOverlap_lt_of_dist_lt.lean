-- Generated from ChapterDisplacedThermalOverlap.lean — theorem BookProof.ChapterDisplacedThermalOverlap.dtOverlap_lt_of_dist_lt
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
open BookProof.ChapterDisplacedThermalOverlap


noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

theorem BookProof.ChapterDisplacedThermalOverlap.dtOverlap_lt_of_dist_lt (nbar : ℝ≥0) {a b c : ℝ}
    (h : (a - b) ^ 2 < (a - c) ^ 2) : dtOverlap nbar a c < dtOverlap nbar a b := by sorry
