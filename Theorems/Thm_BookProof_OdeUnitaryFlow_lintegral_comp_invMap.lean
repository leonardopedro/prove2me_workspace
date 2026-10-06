-- Generated from ChapterOdeUnitaryFlow.lean — theorem BookProof.OdeUnitaryFlow.lintegral_comp_invMap
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow



open MeasureTheory Filter Set
open scoped Topology ENNReal

theorem BookProof.OdeUnitaryFlow.lintegral_comp_invMap (g : ℝ → ℝ≥0∞) :
    ∫⁻ x, ENNReal.ofReal ((x ^ 2)⁻¹) * g (invMap x) = ∫⁻ y, g y := by sorry
