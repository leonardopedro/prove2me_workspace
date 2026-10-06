-- Generated from ChapterAtomicDecomposition.lean — solution of BookProof.ChapterAtomicDecomposition.atoms_countable
import Mathlib
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition



open MeasureTheory


variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X) [SFinite mu] : (atoms mu).Countable := by

  have := Measure.countable_meas_pos_of_disjoint_iUnion (μ := mu)
    (As := fun x : X => ({x} : Set X)) (fun x => measurableSet_singleton x)
    (by intro x y hxy; simpa [Function.onFun] using hxy)
  simpa [atoms] using this
