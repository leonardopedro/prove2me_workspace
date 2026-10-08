-- Generated from ChapterAbelianAtomicCondensation.lean — theorem BookProof.ChapterAbelianAtomicCondensation.atomic_measure_index_dichotomy
import Definitions.Def_ChapterAbelianDiagonalCountable
import Mathlib
import Definitions.Def_ChapterAbelianAtomicCondensation
import Definitions.Def_ChapterAtomicDecomposition
open BookProof.ChapterAtomicDecomposition
open BookProof.ChapterAbelianAtomicCondensation


open scoped ENNReal

noncomputable section


open BookProof.ChapterAbelianDiagonalCountable
open MeasureTheory

theorem BookProof.ChapterAbelianAtomicCondensation.atomic_measure_index_dichotomy {X : Type*} [MeasurableSpace X]
    [MeasurableSingletonClass X] (mu : Measure X) [IsProbabilityMeasure mu] :
    (∃ n : ℕ, Nonempty (atoms mu ≃ Fin n)) ∨ Nonempty (atoms mu ≃ ℕ) := by sorry
