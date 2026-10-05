-- Generated from ChapterNsScalarVectorCurry.lean — theorem BookProof.NsScalarVectorCurry.lintegral_eLpNorm_slice_sq
import Mathlib
import Definitions.Def_ChapterNsScalarVectorCurry
open BookProof.NsScalarVectorCurry

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W}
variable [SigmaFinite μ] [SigmaFinite ν]


open MeasureTheory Filter Set
open scoped ENNReal ComplexConjugate


noncomputable section


theorem BookProof.NsScalarVectorCurry.lintegral_eLpNorm_slice_sq (F : V × W → ℂ) (hF : AEStronglyMeasurable F (μ.prod ν)) :
    ∫⁻ x, (eLpNorm (fun y => F (x, y)) 2 ν) ^ 2 ∂μ = (eLpNorm F 2 (μ.prod ν)) ^ 2 := by sorry
