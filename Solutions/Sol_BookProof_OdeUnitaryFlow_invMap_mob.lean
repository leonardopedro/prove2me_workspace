-- Generated from ChapterOdeUnitaryFlow.lean — solution of BookProof.OdeUnitaryFlow.invMap_mob
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow




open MeasureTheory Filter Set
open scoped Topology ENNReal

set_option maxHeartbeats 1000000 in
theorem solution {t x : ℝ} (hx : x ≠ 0) :
    invMap (mob t x) = invMap x - t := by

  simp only [invMap, mob]
  field_simp
  ring
