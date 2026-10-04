-- Generated from ChapterAbelianCyclicModel.lean — theorem BookProof.ChapterAbelianCyclicModel.isProbabilityMeasure_repMeasure
import Mathlib
import Definitions.Def_ChapterAbelianCyclicModel
import Definitions.Def_ChapterA4
open BookProof.ChapterAbelianCyclicModel

variable {X : Type*} [TopologicalSpace X] [CompactSpace X] [T2Space X]
  [MeasurableSpace X] [BorelSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (pi : C(X, ℂ) →⋆ₐ[ℂ] (H →L[ℂ] H)) (xi : H)


open MeasureTheory Complex WeakDual
open scoped ComplexOrder


open BookProof.ChapterAbelianGelfandModel



theorem BookProof.ChapterAbelianCyclicModel.isProbabilityMeasure_repMeasure (hxi : ‖xi‖ = 1) :
    IsProbabilityMeasure (repMeasure pi xi) := by sorry
