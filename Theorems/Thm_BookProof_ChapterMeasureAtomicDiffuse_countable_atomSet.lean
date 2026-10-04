-- Generated from ChapterMeasureAtomicDiffuse.lean — theorem BookProof.ChapterMeasureAtomicDiffuse.countable_atomSet
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Definitions.Def_ChapterA4
open BookProof.ChapterMeasureAtomicDiffuse

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)


noncomputable section

open MeasureTheory Complex




theorem BookProof.ChapterMeasureAtomicDiffuse.countable_atomSet [IsFiniteMeasure mu] : (atomSet mu).Countable := by sorry
