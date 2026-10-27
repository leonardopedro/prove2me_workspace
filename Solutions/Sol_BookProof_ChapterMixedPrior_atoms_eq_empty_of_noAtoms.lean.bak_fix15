-- Generated from ChapterMixedPrior.lean — solution of BookProof.ChapterMixedPrior.atoms_eq_empty_of_noAtoms
import Mathlib
import Definitions.Def_ChapterMixedPrior
open BookProof.ChapterMixedPrior



open MeasureTheory ProbabilityTheory


open BookProof.ChapterAtomicDecomposition

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]

set_option maxHeartbeats 1000000 in
theorem solution (mu : Measure X) [NullSingletonClass mu] : atoms mu = ∅ := by

  ext x
  simp only [atoms, Set.mem_ofPred_eq, measure_singleton x, lt_self_iff_false,
    Set.mem_empty_iff_false]
