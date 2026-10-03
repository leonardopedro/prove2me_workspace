-- Generated from ChapterNsScalarVectorCurry.lean — theorem BookProof.NsScalarVectorCurry.curryLI_setIntegral_rect
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry
import Definitions.Def_ChapterA4

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}
variable [SigmaFinite μ] [SigmaFinite ν]


open MeasureTheory Filter Set
open scoped ENNReal ComplexConjugate


noncomputable section


theorem BookProof.NsScalarVectorCurry.curryLI_setIntegral_rect (f : Lp (Lp ℂ 2 ν) 2 μ) {s : Set V} {t : Set W}
    (hs : MeasurableSet s) (ht : MeasurableSet t) (hμs : μ s ≠ ∞) (hνt : ν t ≠ ∞)
    (hst : (μ.prod ν) (s ×ˢ t) ≠ ∞) :
    ∫ z in s ×ˢ t, (curryLI f : V × W → ℂ) z ∂(μ.prod ν)
      = ∫ x in s, (∫ y in t, ((f : V → Lp ℂ 2 ν) x : W → ℂ) y ∂ν) ∂μ := by sorry
