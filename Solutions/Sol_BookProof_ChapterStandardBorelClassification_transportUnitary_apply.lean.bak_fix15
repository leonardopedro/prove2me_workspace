-- Generated from ChapterStandardBorelClassification.lean — solution of BookProof.ChapterStandardBorelClassification.transportUnitary_apply
import Mathlib
import Definitions.Def_ChapterStandardBorelClassification
open BookProof.ChapterStandardBorelClassification



noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterAtomicDiagonalModel
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterAbelianClassificationList

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y] (e : X ≃ᵐ Y)
  (mu : Measure X)

set_option maxHeartbeats 1000000 in
theorem solution (v : Lp ℂ 2 (Measure.map e mu)) :
    transportUnitary e mu v = transportIsom e mu v := rfl
