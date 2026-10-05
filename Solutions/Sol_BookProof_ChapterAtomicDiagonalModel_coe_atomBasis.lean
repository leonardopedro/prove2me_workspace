-- Generated from ChapterAtomicDiagonalModel.lean — solution of BookProof.ChapterAtomicDiagonalModel.coe_atomBasis
import Mathlib
import Definitions.Def_ChapterAtomicDiagonalModel
open BookProof.ChapterAtomicDiagonalModel



noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]
  (mu : Measure α) [IsFiniteMeasure mu]

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]
  (mu : Measure α) [IsFiniteMeasure mu]

set_option maxHeartbeats 1000000 in
theorem solution (hpure : mu (atomSet mu)ᶜ = 0) :
    ⇑(atomBasis mu hpure) = atomVec mu := HilbertBasis.coe_mkOfOrthogonalEqBot _ _
