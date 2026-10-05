-- Generated from ChapterNsScalarVectorCurry.lean — theorem BookProof.NsScalarVectorCurry.curryLI_indicator_prod
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry
open BookProof.NsScalarVectorCurry

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}
variable [SigmaFinite μ] [SigmaFinite ν]


open MeasureTheory Filter Set
open scoped ENNReal ComplexConjugate


noncomputable section


theorem BookProof.NsScalarVectorCurry.curryLI_indicator_prod {s : Set V} {t : Set W} (hs : MeasurableSet s)
    (ht : MeasurableSet t) (hμs : μ s ≠ ∞) (hνt : ν t ≠ ∞)
    (hst : (μ.prod ν) (s ×ˢ t) ≠ ∞) :
    curryLI (fibMk (indicatorConstLp 2 hs hμs (1 : ℂ)) (indicatorConstLp 2 ht hνt (1 : ℂ)))
      = indicatorConstLp 2 (hs.prod ht) hst (1 : ℂ) := by sorry
