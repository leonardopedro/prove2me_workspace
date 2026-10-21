-- Generated from ChapterStandardBorelClassification.lean — solution of BookProof.ChapterStandardBorelClassification.standardBorel_classification_list
import Mathlib
import Definitions.Def_ChapterStandardBorelClassification
import Theorems.Thm_BookProof_ChapterStandardBorelClassification_standardBorel_multiplication_model_transport
import Theorems.Thm_BookProof_ChapterAbelianClassificationList_vonNeumann_abelian_classification_list
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

set_option maxHeartbeats 1000000 in
theorem solution : RealizesStandardType mu := by

  rcases standardBorel_multiplication_model_transport mu with h | ⟨e, hprob, hU⟩
  · exact Or.inl h
  · haveI := hprob
    exact Or.inr ⟨e, hprob, hU, vonNeumann_abelian_classification_list (Measure.map e mu)⟩
