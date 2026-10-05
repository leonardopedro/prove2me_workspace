-- Generated from ChapterMeasureAtomicDiffuse.lean — theorem BookProof.ChapterMeasureAtomicDiffuse.mem_atomSet_iff
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
open BookProof.ChapterMeasureAtomicDiffuse

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)


noncomputable section

open MeasureTheory Complex




theorem BookProof.ChapterMeasureAtomicDiffuse.mem_atomSet_iff (x : α) : x ∈ atomSet mu ↔ mu {x} ≠ 0 := by sorry
