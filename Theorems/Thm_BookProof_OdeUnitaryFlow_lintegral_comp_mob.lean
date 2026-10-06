-- Generated from ChapterOdeUnitaryFlow.lean — theorem BookProof.OdeUnitaryFlow.lintegral_comp_mob
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow



open MeasureTheory Filter Set
open scoped Topology ENNReal

theorem BookProof.OdeUnitaryFlow.lintegral_comp_mob (t : ℝ) (g : ℝ → ℝ≥0∞) :
    ∫⁻ x, ENNReal.ofReal ((1 + t * x) ^ 2)⁻¹ * g (mob t x) = ∫⁻ y, g y := by sorry
