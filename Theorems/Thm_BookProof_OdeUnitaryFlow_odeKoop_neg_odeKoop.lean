-- Generated from ChapterOdeUnitaryFlow.lean — theorem BookProof.OdeUnitaryFlow.odeKoop_neg_odeKoop
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow



open MeasureTheory Filter Set
open scoped Topology ENNReal

theorem BookProof.OdeUnitaryFlow.odeKoop_neg_odeKoop (t : ℝ) (ψ : ℝ → ℂ) (x : ℝ) (hx : x ∈ flowDom (-t)) :
    odeKoop (-t) (odeKoop t ψ) x = ψ x := by sorry
