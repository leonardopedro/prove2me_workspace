-- Generated from ChapterMeasureAtomicDiffuse.lean — theorem BookProof.ChapterMeasureAtomicDiffuse.restrict_atomSet_add_restrict_compl
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Definitions.Def_ChapterA4
open BookProof.ChapterMeasureAtomicDiffuse

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)


noncomputable section

open MeasureTheory Complex




theorem BookProof.ChapterMeasureAtomicDiffuse.restrict_atomSet_add_restrict_compl [IsFiniteMeasure mu] :
    mu.restrict (atomSet mu) + mu.restrict (atomSet mu)ᶜ = mu := by sorry
