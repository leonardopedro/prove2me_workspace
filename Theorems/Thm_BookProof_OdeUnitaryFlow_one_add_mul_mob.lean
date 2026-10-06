-- Generated from ChapterOdeUnitaryFlow.lean — theorem BookProof.OdeUnitaryFlow.one_add_mul_mob
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow



open MeasureTheory Filter Set
open scoped Topology ENNReal

theorem BookProof.OdeUnitaryFlow.one_add_mul_mob (s t x : ℝ) (hx : 1 + t * x ≠ 0) :
    1 + s * mob t x = (1 + (s + t) * x) / (1 + t * x) := by sorry
