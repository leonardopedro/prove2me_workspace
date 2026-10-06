-- Generated from ChapterDisplacedThermalOverlap.lean — solution of BookProof.ChapterDisplacedThermalOverlap.dtBorn_temperature_coth
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
import Theorems.Thm_BookProof_ChapterBoseEinstein_boseEinstein_pos
import Theorems.Thm_BookProof_ChapterBoseEinstein_thermalTemperature_boseEinstein_eq_coth
open BookProof.ChapterDisplacedThermalOverlap



noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

set_option maxHeartbeats 1000000 in
theorem solution {x : ℝ} (hx : 0 < x) :
    ((BookProof.ChapterBoseEinstein.boseEinstein x).toNNReal : ℝ) + 1 / 2
      = Real.cosh (x / 2) / (2 * Real.sinh (x / 2)) := by

  have hpos : 0 < BookProof.ChapterBoseEinstein.boseEinstein x :=
    BookProof.ChapterBoseEinstein.boseEinstein_pos hx
  rw [Real.coe_toNNReal _ hpos.le]
  exact BookProof.ChapterBoseEinstein.thermalTemperature_boseEinstein_eq_coth hx
