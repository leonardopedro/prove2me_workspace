-- Generated from ChapterOdeUnitaryFlow.lean — theorem BookProof.OdeUnitaryFlow.hasDerivAt_odeKoop_zero
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow



open MeasureTheory Filter Set
open scoped Topology ENNReal

theorem BookProof.OdeUnitaryFlow.hasDerivAt_odeKoop_zero (ψ : ℝ → ℂ) (x : ℝ) (d : ℂ) (hψ : HasDerivAt ψ d x) :
    HasDerivAt (fun t : ℝ => odeKoop t ψ x) (-((x : ℂ) ^ 2 * d + (x : ℂ) * ψ x)) 0 := by sorry
