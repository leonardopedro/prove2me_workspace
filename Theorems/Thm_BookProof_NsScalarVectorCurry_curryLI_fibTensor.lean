-- Generated from ChapterNsScalarVectorCurry.lean — theorem BookProof.NsScalarVectorCurry.curryLI_fibTensor
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry
import Definitions.Def_ChapterA4

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}
variable [SigmaFinite μ] [SigmaFinite ν]


open MeasureTheory Filter Set
open scoped ENNReal ComplexConjugate


noncomputable section


theorem BookProof.NsScalarVectorCurry.curryLI_fibTensor (t : TensorProduct ℂ (Lp ℂ 2 μ) (Lp ℂ 2 ν)) :
    curryLI (fibTensor t) = prodTensor t := by sorry
