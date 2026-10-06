-- Generated from ChapterMixedPrior.lean — theorem BookProof.ChapterMixedPrior.atoms_eq_empty_of_noAtoms
import Mathlib
import Definitions.Def_ChapterMixedPrior
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition
open BookProof.ChapterMixedPrior

variable {X : Type*} [MeasurableSpace X] [MeasurableSingletonClass X]


open MeasureTheory ProbabilityTheory


open BookProof.ChapterAtomicDecomposition


theorem BookProof.ChapterMixedPrior.atoms_eq_empty_of_noAtoms (mu : Measure X) [NullSingletonClass mu] : atoms mu = ∅ := by sorry
