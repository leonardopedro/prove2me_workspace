-- Generated from ChapterStandardBorelClassification.lean — theorem BookProof.ChapterStandardBorelClassification.transportUnitary_apply
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Definitions.Def_ChapterAtomicDiagonalModel
import Definitions.Def_ChapterLinftyMultiplication
import Definitions.Def_ChapterAbelianClassificationList
import Mathlib
import Definitions.Def_ChapterStandardBorelClassification
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport
open BookProof.ChapterStandardBorelClassification

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y] (e : X ≃ᵐ Y)
  (mu : Measure X)


noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterAbelianClassificationList

theorem BookProof.ChapterStandardBorelClassification.transportUnitary_apply (v : Lp ℂ 2 (Measure.map e mu)) :
    transportUnitary e mu v = transportIsom e mu v := by sorry
