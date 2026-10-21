-- Generated from ChapterPvmCyclicDecomposition.lean — solution of BookProof.ChapterPvmCyclicDecomposition.exists_countable_cyclic_decomposition
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_mem_cyclicSubspace_self
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_exists_cyclic_decomposition
import Theorems.Thm_BookProof_ChapterPvmCyclicDecomposition_countable_of_orthCyclicFamily
open BookProof.ChapterPvmCyclicDecomposition



open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution [CompleteSpace H]
    [TopologicalSpace.SeparableSpace H] (P : Pvm X H) :
    ∃ S : Set H, S.Countable ∧ OrthCyclicFamily P S ∧
      Dense ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H) ∧
      ∀ ψ ∈ S, IsCyclic (restrictCyclic P ψ) ⟨ψ, mem_cyclicSubspace_self P ψ⟩ := by

  obtain ⟨S, hS, hdense, hcyc⟩ := exists_cyclic_decomposition P
  exact ⟨S, countable_of_orthCyclicFamily hS, hS, hdense, hcyc⟩
