-- Generated from ChapterOdeUnitaryFlow.lean — theorem BookProof.OdeUnitaryFlow.odeKoop_lintegral_normSq
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow



open MeasureTheory Filter Set
open scoped Topology ENNReal

theorem BookProof.OdeUnitaryFlow.odeKoop_lintegral_normSq (t : ℝ) (ψ : ℝ → ℂ) :
    ∫⁻ x, ENNReal.ofReal (‖odeKoop t ψ x‖ ^ 2) = ∫⁻ y, ENNReal.ofReal (‖ψ y‖ ^ 2) := by sorry
