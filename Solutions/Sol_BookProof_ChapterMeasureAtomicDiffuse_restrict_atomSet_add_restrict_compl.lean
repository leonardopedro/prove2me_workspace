-- Generated from ChapterMeasureAtomicDiffuse.lean — solution of BookProof.ChapterMeasureAtomicDiffuse.restrict_atomSet_add_restrict_compl
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Theorems.Thm_BookProof_ChapterMeasureAtomicDiffuse_measurableSet_atomSet
open BookProof.ChapterMeasureAtomicDiffuse



noncomputable section

open MeasureTheory Complex



variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)

set_option maxHeartbeats 1000000 in
theorem solution [IsFiniteMeasure mu] :
    mu.restrict (atomSet mu) + mu.restrict (atomSet mu)ᶜ = mu := Measure.restrict_add_restrict_compl (measurableSet_atomSet mu)
