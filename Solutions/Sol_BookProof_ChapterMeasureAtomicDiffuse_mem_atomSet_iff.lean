-- Generated from ChapterMeasureAtomicDiffuse.lean — solution of BookProof.ChapterMeasureAtomicDiffuse.mem_atomSet_iff
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
open BookProof.ChapterMeasureAtomicDiffuse



noncomputable section

open MeasureTheory Complex



variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)

set_option maxHeartbeats 1000000 in
theorem solution (x : α) : x ∈ atomSet mu ↔ mu {x} ≠ 0 := Iff.rfl
