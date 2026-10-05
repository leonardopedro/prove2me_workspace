-- Generated from ChapterStandardBorelClassification.lean — theorem BookProof.ChapterStandardBorelClassification.purelyAtomic_of_countable
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Definitions.Def_ChapterAtomicDiagonalModel
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterAbelianClassificationList
import Mathlib
import Definitions.Def_ChapterStandardBorelClassification
open BookProof.ChapterStandardBorelClassification

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y] (e : X ≃ᵐ Y)
  (mu : Measure X)


noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterAbelianClassificationList

theorem BookProof.ChapterStandardBorelClassification.purelyAtomic_of_countable {X : Type*} [MeasurableSpace X]
    [MeasurableSingletonClass X] [Countable X] (mu : Measure X) :
    mu (atomSet mu)ᶜ = 0 := by sorry
