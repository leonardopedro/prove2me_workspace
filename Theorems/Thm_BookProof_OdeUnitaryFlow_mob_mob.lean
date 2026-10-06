-- Generated from ChapterOdeUnitaryFlow.lean — theorem BookProof.OdeUnitaryFlow.mob_mob
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow



open MeasureTheory Filter Set
open scoped Topology ENNReal

theorem BookProof.OdeUnitaryFlow.mob_mob (s t x : ℝ) (hx : 1 + t * x ≠ 0) (hst : 1 + (s + t) * x ≠ 0) :
    mob s (mob t x) = mob (s + t) x := by sorry
