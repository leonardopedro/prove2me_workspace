-- Generated from ChapterAtomicDiagonalModel.lean — theorem BookProof.ChapterAtomicDiagonalModel.atomVec_coeFn
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Definitions.Def_ChapterLinftyMultiplication
import Mathlib
import Definitions.Def_ChapterAtomicDiagonalModel
open BookProof.ChapterAtomicDiagonalModel

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α]
  (mu : Measure α) [IsFiniteMeasure mu]


noncomputable section

open MeasureTheory


open BookProof.ChapterMeasureAtomicDiffuse BookProof.ChapterLinftyMultiplication


theorem BookProof.ChapterAtomicDiagonalModel.atomVec_coeFn (a : atomSet mu) :
    (atomVec mu a : α → ℂ) =ᵐ[mu] fun x =>
      (((Real.sqrt (mu.real {(a : α)}))⁻¹ : ℝ) : ℂ) *
        Set.indicator {(a : α)} (fun _ => (1 : ℂ)) x := by sorry
