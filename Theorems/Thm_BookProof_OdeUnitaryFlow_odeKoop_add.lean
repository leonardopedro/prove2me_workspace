-- Generated from ChapterOdeUnitaryFlow.lean — theorem BookProof.OdeUnitaryFlow.odeKoop_add
import Mathlib
import Definitions.Def_ChapterOdeUnitaryFlow
open BookProof.OdeUnitaryFlow



open MeasureTheory Filter Set
open scoped Topology ENNReal

theorem BookProof.OdeUnitaryFlow.odeKoop_add (s t : ℝ) (ψ : ℝ → ℂ) (x : ℝ) (hs : 1 + s * x ≠ 0)
    (hst : 1 + (s + t) * x ≠ 0) :
    odeKoop s (odeKoop t ψ) x = odeKoop (s + t) ψ x := by sorry
