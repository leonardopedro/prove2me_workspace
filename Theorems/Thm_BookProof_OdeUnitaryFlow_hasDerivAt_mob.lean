-- Generated from ChapterOdeUnitaryFlow.lean — theorem BookProof.OdeUnitaryFlow.hasDerivAt_mob
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow



open MeasureTheory Filter Set
open scoped Topology ENNReal

theorem BookProof.OdeUnitaryFlow.hasDerivAt_mob (t x : ℝ) (hx : x ∈ flowDom t) :
    HasDerivAt (mob t) ((1 + t * x) ^ 2)⁻¹ x := by sorry
