-- Generated from ChapterMeasureAtomicDiffuse.lean — solution of BookProof.ChapterMeasureAtomicDiffuse.measurableSet_atomSet
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Theorems.Thm_BookProof_ChapterMeasureAtomicDiffuse_countable_atomSet
open BookProof.ChapterMeasureAtomicDiffuse



noncomputable section

open MeasureTheory Complex



variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)

set_option maxHeartbeats 1000000 in
theorem solution [IsFiniteMeasure mu] : MeasurableSet (atomSet mu) := (countable_atomSet mu).measurableSet
