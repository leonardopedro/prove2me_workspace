-- Generated from ChapterMeasureAtomicDiffuse.lean — theorem BookProof.ChapterMeasureAtomicDiffuse.restrict_eq_sum_dirac
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
open BookProof.ChapterMeasureAtomicDiffuse


noncomputable section

open MeasureTheory Complex



variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)


theorem BookProof.ChapterMeasureAtomicDiffuse.restrict_eq_sum_dirac {A : Set α} (hc : A.Countable) :
    mu.restrict A = Measure.sum (fun x : A => mu {(x : α)} • Measure.dirac (x : α)) := by sorry
