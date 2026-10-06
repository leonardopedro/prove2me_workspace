-- Generated from ChapterDisplacedThermalOverlap.lean — theorem BookProof.ChapterDisplacedThermalOverlap.dtBorn_temperature_coth
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
import Definitions.Def_ChapterBoseEinstein
open BookProof.ChapterBoseEinstein
open BookProof.ChapterDisplacedThermalOverlap


noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

theorem BookProof.ChapterDisplacedThermalOverlap.dtBorn_temperature_coth {x : ℝ} (hx : 0 < x) :
    ((BookProof.ChapterBoseEinstein.boseEinstein x).toNNReal : ℝ) + 1 / 2
      = Real.cosh (x / 2) / (2 * Real.sinh (x / 2)) := by sorry
