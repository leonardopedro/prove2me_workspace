-- Generated from ChapterNsScalarVectorCurry.lean — theorem BookProof.NsScalarVectorCurry.isSliceOf_fibTensor
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry
import Definitions.Def_ChapterSirkFinitePrecision
import Definitions.Def_ChapterA4
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}
variable [SigmaFinite μ] [SigmaFinite ν]


open MeasureTheory Filter Set
open scoped ENNReal ComplexConjugate


noncomputable section


theorem BookProof.NsScalarVectorCurry.isSliceOf_fibTensor (t : TensorProduct ℂ (Lp ℂ 2 μ) (Lp ℂ 2 ν)) :
    IsSliceOf (fibTensor t) (prodTensor t) := by sorry
