-- Generated from ChapterStandardBorelClassification.lean — theorem BookProof.ChapterStandardBorelClassification.spectral_multiplication_model_classified
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Definitions.Def_ChapterAtomicDiagonalModel
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterAbelianClassificationList
import Mathlib
import Definitions.Def_ChapterStandardBorelClassification
open BookProof.ChapterStandardBorelClassification

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y] (e : X ≃ᵐ Y)
  (mu : Measure X)
variable {X : Type*} [MeasurableSpace X] [StandardBorelSpace X]
  (mu : Measure X) [IsProbabilityMeasure mu]
variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y]
  [TopologicalSpace.MetrizableSpace Y] [MeasurableSpace Y] [BorelSpace Y]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterAbelianClassificationList

theorem BookProof.ChapterStandardBorelClassification.spectral_multiplication_model_classified (T : H →L[ℂ] H) (hT : IsStarNormal T) :
    ∃ (S : Set H) (mu : S → Measure (spectrum ℂ T))
      (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) (coordFn T) u) = T (V x u)) ∧
      (∀ x : S, ∃ _ : IsProbabilityMeasure (mu x), RealizesStandardType (mu x)) := by sorry
