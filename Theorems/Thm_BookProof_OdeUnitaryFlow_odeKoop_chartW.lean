-- Generated from ChapterOdeUnitaryFlow.lean — theorem BookProof.OdeUnitaryFlow.odeKoop_chartW
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow



open MeasureTheory Filter Set
open scoped Topology ENNReal

theorem BookProof.OdeUnitaryFlow.odeKoop_chartW (t : ℝ) (ψ : ℝ → ℂ) {x : ℝ} (hx : x ≠ 0) (h : 1 + t * x ≠ 0) :
    odeKoop t (chartW ψ) x = chartW (transl t ψ) x := by sorry
