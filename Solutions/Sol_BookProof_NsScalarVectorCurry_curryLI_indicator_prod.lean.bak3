-- Generated from ChapterNsScalarVectorCurry.lean — solution of BookProof.NsScalarVectorCurry.curryLI_indicator_prod
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry
import Theorems.Thm_BookProof_NsScalarVectorCurry_curryLI_fibMk
open BookProof.NsScalarVectorCurry



open MeasureTheory Filter Set
open scoped ENNReal ComplexConjugate


noncomputable section

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}
variable [SigmaFinite μ] [SigmaFinite ν]

set_option maxHeartbeats 1000000 in
theorem solution {s : Set V} {t : Set W} (hs : MeasurableSet s)
    (ht : MeasurableSet t) (hμs : μ s ≠ ∞) (hνt : ν t ≠ ∞)
    (hst : (μ.prod ν) (s ×ˢ t) ≠ ∞) :
    curryLI (fibMk (indicatorConstLp 2 hs hμs (1 : ℂ)) (indicatorConstLp 2 ht hνt (1 : ℂ)))
      = indicatorConstLp 2 (hs.prod ht) hst (1 : ℂ) := by

  rw [curryLI_fibMk, prodMk_indicatorConstLp hs ht hμs hνt hst]
