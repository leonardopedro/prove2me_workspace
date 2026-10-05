-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.exists_cyclic_decomposition
import Definitions.Def_ChapterPvmMeasure
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
open BookProof.ChapterPvmCyclicDecomposition

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure


theorem BookProof.ChapterPvmCyclicDecomposition.exists_cyclic_decomposition [CompleteSpace H] (P : Pvm X H) :
    ∃ S : Set H, OrthCyclicFamily P S ∧
      Dense ((Submodule.span ℂ (familyOrbit P S) : Submodule ℂ H) : Set H) ∧
      ∀ ψ ∈ S, IsCyclic (restrictCyclic P ψ) ⟨ψ, mem_cyclicSubspace_self P ψ⟩ := by sorry
