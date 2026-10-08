-- Generated from ChapterAbelianClassificationList.lean — theorem BookProof.ChapterAbelianClassificationList.vonNeumann_abelian_classification_list
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Definitions.Def_ChapterAtomicDiagonalModel
import Definitions.Def_ChapterDiffuseUnitaryModel
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterLpRestrictSplit
import Definitions.Def_ChapterLpScaleMeasure
import Mathlib
import Definitions.Def_ChapterAbelianClassificationList
open BookProof.ChapterAbelianClassificationList


noncomputable section

open MeasureTheory ProbabilityTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterDiffuseUnitaryModel BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLpRestrictSplit BookProof.ChapterLpScaleMeasure

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]
variable (nu : Measure ℝ) [IsFiniteMeasure nu] [NullSingletonClass nu]
variable (mu : Measure ℝ) [IsProbabilityMeasure mu]

theorem BookProof.ChapterAbelianClassificationList.vonNeumann_abelian_classification_list :
    (atomSet mu).Countable ∧
      ((mu (atomSet mu)ᶜ = 0 ∧ (atomSet mu).Finite) ∨
        (mu (atomSet mu)ᶜ = 0 ∧ (atomSet mu).Infinite ∧
          Nonempty (atomSet mu ≃ ℕ)) ∨
        (mu (atomSet mu) = 0 ∧ atomSet mu = ∅) ∨
        (mu (atomSet mu) ≠ 0 ∧ mu (atomSet mu)ᶜ ≠ 0 ∧ (atomSet mu).Finite) ∨
        (mu (atomSet mu) ≠ 0 ∧ mu (atomSet mu)ᶜ ≠ 0 ∧ (atomSet mu).Infinite ∧
          Nonempty (atomSet mu ≃ ℕ))) := by sorry
