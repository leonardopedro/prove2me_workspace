-- Generated from ChapterOdeUnitaryFlow.lean — theorem BookProof.OdeUnitaryFlow.classicalSol_tendsto_atTop
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow



open MeasureTheory Filter Set
open scoped Topology ENNReal

theorem BookProof.OdeUnitaryFlow.classicalSol_tendsto_atTop (x₀ : ℝ) (hx₀ : 0 < x₀) :
    Tendsto (classicalSol x₀) (𝓝[<] (1 / x₀)) atTop := by sorry
