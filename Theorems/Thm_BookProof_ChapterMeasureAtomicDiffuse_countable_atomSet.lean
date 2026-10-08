-- Generated from ChapterMeasureAtomicDiffuse.lean — theorem BookProof.ChapterMeasureAtomicDiffuse.countable_atomSet
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
open BookProof.ChapterMeasureAtomicDiffuse


noncomputable section

open MeasureTheory Complex



variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)


theorem BookProof.ChapterMeasureAtomicDiffuse.countable_atomSet [IsFiniteMeasure mu] : (atomSet mu).Countable := by sorry
