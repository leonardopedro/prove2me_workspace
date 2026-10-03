-- Generated from ChapterNsScalarVectorCurry.lean — theorem BookProof.NsScalarVectorCurry.IsSliceOf.add
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry
import Definitions.Def_ChapterA4

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}
variable [SigmaFinite μ] [SigmaFinite ν]


open MeasureTheory Filter Set
open scoped ENNReal ComplexConjugate


noncomputable section


theorem BookProof.NsScalarVectorCurry.IsSliceOf.add {f₁ f₂ : Lp (Lp ℂ 2 ν) 2 μ} {g₁ g₂ : Lp ℂ 2 (μ.prod ν)}
    (h₁ : IsSliceOf f₁ g₁) (h₂ : IsSliceOf f₂ g₂) : IsSliceOf (f₁ + f₂) (g₁ + g₂) := by sorry
