-- Generated from ChapterNsScalarVectorCurry.lean — solution of BookProof.NsScalarVectorCurry.curryLI_fibTensor
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry



open MeasureTheory Filter Set
open scoped ENNReal ComplexConjugate


noncomputable section

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}
variable [SigmaFinite μ] [SigmaFinite ν]

set_option maxHeartbeats 1000000 in
theorem solution (t : TensorProduct ℂ (Lp ℂ 2 μ) (Lp ℂ 2 ν)) :
    curryLI (fibTensor t) = prodTensor t := LinearEquiv.extendOfIsometry_eq _ _ _ _ _ _ t
