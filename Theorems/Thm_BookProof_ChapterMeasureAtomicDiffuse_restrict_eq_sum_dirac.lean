-- Generated from ChapterMeasureAtomicDiffuse.lean — theorem BookProof.ChapterMeasureAtomicDiffuse.restrict_eq_sum_dirac
import Mathlib
import Definitions.Def_ChapterMeasureAtomicDiffuse
import Definitions.Def_ChapterA4
open BookProof.ChapterMeasureAtomicDiffuse

variable {α : Type*} [MeasurableSpace α] [MeasurableSingletonClass α] (mu : Measure α)


noncomputable section

open MeasureTheory Complex




theorem BookProof.ChapterMeasureAtomicDiffuse.restrict_eq_sum_dirac {A : Set α} (hc : A.Countable) :
    mu.restrict A = Measure.sum (fun x : A => mu {(x : α)} • Measure.dirac (x : α)) := by sorry
