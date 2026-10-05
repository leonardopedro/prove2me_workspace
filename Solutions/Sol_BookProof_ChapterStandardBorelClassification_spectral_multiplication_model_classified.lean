-- Generated from ChapterStandardBorelClassification.lean — solution of BookProof.ChapterStandardBorelClassification.spectral_multiplication_model_classified
import Mathlib
import Definitions.Def_ChapterStandardBorelClassification
import Theorems.Thm_BookProof_ChapterStandardBorelClassification_standardBorel_classification_list
import Theorems.Thm_BookProof_ChapterSpectralDirectSum_spectral_multiplication_model_general
open BookProof.ChapterStandardBorelClassification



noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterAbelianClassificationList

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y] (e : X ≃ᵐ Y)
  (mu : Measure X)
variable {X : Type*} [MeasurableSpace X] [StandardBorelSpace X]
  (mu : Measure X) [IsProbabilityMeasure mu]
variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y]
  [TopologicalSpace.MetrizableSpace Y] [MeasurableSpace Y] [BorelSpace Y]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : H →L[ℂ] H) (hT : IsStarNormal T) :
    ∃ (S : Set H) (mu : S → Measure (spectrum ℂ T))
      (V : ∀ x : S, Lp ℂ 2 (mu x) →ₗᵢ[ℂ] H),
      (∀ x : S, IsProbabilityMeasure (mu x)) ∧
      IsHilbertSum ℂ (fun x : S => Lp ℂ 2 (mu x)) V ∧
      (∀ (x : S) (u : Lp ℂ 2 (mu x)),
        V x (mulRep (mu x) (coordFn T) u) = T (V x u)) ∧
      (∀ x : S, ∃ _ : IsProbabilityMeasure (mu x), RealizesStandardType (mu x)) := by

  obtain ⟨S, mu, V, hprob, hsum, hint⟩ := spectral_multiplication_model_general T hT
  refine ⟨S, mu, V, hprob, hsum, hint, fun x => ?_⟩
  haveI := hprob x
  exact ⟨hprob x, standardBorel_classification_list (mu x)⟩
