-- Generated from ChapterLinftyMultiplication.lean — theorem BookProof.ChapterLinftyMultiplication.unitInterval_atomless
import Mathlib
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α}


noncomputable section

open MeasureTheory ENNReal Complex



theorem BookProof.ChapterLinftyMultiplication.unitInterval_atomless (x : ℝ) :
    (MeasureTheory.volume.restrict (Set.Icc (0 : ℝ) 1)) {x} = 0 := by sorry
