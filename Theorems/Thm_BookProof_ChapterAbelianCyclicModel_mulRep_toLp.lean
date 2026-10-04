-- Generated from ChapterAbelianCyclicModel.lean — theorem BookProof.ChapterAbelianCyclicModel.mulRep_toLp
import Mathlib
import Definitions.Def_ChapterAbelianCyclicModel
import Definitions.Def_ChapterA4
open BookProof.ChapterAbelianCyclicModel

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H)
variable (hcyc : DenseRange (repVec pi xi))


open MeasureTheory Complex WeakDual
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel



theorem BookProof.ChapterAbelianCyclicModel.mulRep_toLp (g f : C(X, ℂ)) :
    mulRep (repMeasure pi xi) g (ContinuousMap.toLp 2 (repMeasure pi xi) ℂ f)
      = ContinuousMap.toLp 2 (repMeasure pi xi) ℂ (g * f) := by sorry
