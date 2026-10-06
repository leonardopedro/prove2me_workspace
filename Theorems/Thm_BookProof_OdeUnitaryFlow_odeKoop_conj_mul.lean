-- Generated from ChapterOdeUnitaryFlow.lean — theorem BookProof.OdeUnitaryFlow.odeKoop_conj_mul
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow



open MeasureTheory Filter Set
open scoped Topology ENNReal

theorem BookProof.OdeUnitaryFlow.odeKoop_conj_mul (t : ℝ) (ρ ψ : ℝ → ℂ) (x : ℝ) (hx : x ∈ flowDom t) :
    odeKoop t (fun y => ρ y * odeKoop (-t) ψ y) x = ρ (mob t x) * ψ x := by sorry
