-- Generated from ChapterNsScalarVectorCurry.lean — theorem BookProof.NsScalarVectorCurry.isSliceOf_fibMk
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry
open BookProof.NsScalarVectorCurry

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}
variable [SigmaFinite μ] [SigmaFinite ν]


open MeasureTheory Filter Set
open scoped ENNReal ComplexConjugate


noncomputable section


theorem BookProof.NsScalarVectorCurry.isSliceOf_fibMk (a : Lp ℂ 2 μ) (c : Lp ℂ 2 ν) : IsSliceOf (fibMk a c) (prodMk a c) := by sorry
