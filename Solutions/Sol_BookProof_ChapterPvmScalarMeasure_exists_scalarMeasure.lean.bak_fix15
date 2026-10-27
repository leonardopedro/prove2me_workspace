-- Generated from ChapterPvmScalarMeasure.lean — solution of BookProof.ChapterPvmScalarMeasure.exists_scalarMeasure
import Mathlib
import Definitions.Def_ChapterPvmScalarMeasure
import Theorems.Thm_BookProof_ChapterPvmScalarMeasure_scalarMeasure_univ_le
import Theorems.Thm_BookProof_ChapterPvmScalarMeasure_scalarMeasure_eq_zero_iff_p_eq_zero
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_countable_of_orthCyclicFamily
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_exists_orthCyclicFamily
open BookProof.ChapterPvmScalarMeasure



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure BookProof.ChapterPvmCyclicDecomposition
open BookProof.ChapterMackeyQuasiInvariant BookProof.ChapterMackeyConverse
open BookProof.ChapterPvmInducedSystem

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H] [TopologicalSpace.SeparableSpace H]
    (P : Pvm X H) :
    ∃ μ : Measure X, IsFiniteMeasure μ ∧
      ∀ E : Set X, MeasurableSet E → (μ E = 0 ↔ P.p E = 0) := by

  obtain ⟨S, hS, hdense⟩ := exists_orthCyclicFamily P
  haveI : Countable S := (countable_of_orthCyclicFamily hS).to_subtype
  obtain ⟨n, hn⟩ := Countable.exists_injective_nat S
  refine ⟨scalarMeasure P S n, ⟨?_⟩, fun E hE => scalarMeasure_eq_zero_iff_p_eq_zero hdense hE⟩
  exact lt_of_le_of_lt (scalarMeasure_univ_le P hn hS.unit) (by norm_num)
