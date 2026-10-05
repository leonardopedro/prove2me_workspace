-- Generated from ChapterNsScalarVectorCurry.lean — solution of BookProof.NsScalarVectorCurry.prodTensor_tmul
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
theorem solution (a : Lp ℂ 2 μ) (c : Lp ℂ 2 ν) :
    prodTensor (a ⊗ₜ[ℂ] c) = prodMk a c := rfl
