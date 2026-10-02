-- Generated from ChapterWeakSecondDerivative.lean — solution of BookProof.WeakSecondDeriv.absolutelyContinuous_primitive
import Mathlib
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.WeakSecondDeriv




open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [NormedSpace ℝ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {G : ℝ → ℝ} (hG : LocallyIntegrable G volume)
    {a b c : ℝ} (hc : c ∈ uIcc a b) :
    AbsolutelyContinuousOnInterval (fun x => ∫ t in c..x, G t) a b :=
  IntervalIntegrable.absolutelyContinuousOnInterval_intervalIntegral
      (hG.integrableOn_isCompact isCompact_uIcc).intervalIntegrable hc
