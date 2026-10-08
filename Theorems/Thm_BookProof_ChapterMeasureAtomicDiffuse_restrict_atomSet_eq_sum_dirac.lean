-- Generated from ChapterMeasureAtomicDiffuse.lean — theorem BookProof.ChapterMeasureAtomicDiffuse.restrict_atomSet_eq_sum_dirac
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
open BookProof.ChapterMeasureAtomicDiffuse


noncomputable section

open MeasureTheory Complex



variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)


theorem BookProof.ChapterMeasureAtomicDiffuse.restrict_atomSet_eq_sum_dirac [IsFiniteMeasure mu] :
    mu.restrict (atomSet mu)
      = Measure.sum (fun x : atomSet mu => mu {(x : α)} • Measure.dirac (x : α)) := by sorry
