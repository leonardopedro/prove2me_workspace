-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.isCyclic_restrictCyclic
import Definitions.Def_ChapterPvmMeasure
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
open BookProof.ChapterPvmCyclicDecomposition


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


theorem BookProof.ChapterPvmCyclicDecomposition.isCyclic_restrictCyclic [CompleteSpace H] (P : Pvm X H) (ψ : H) :
    IsCyclic (restrictCyclic P ψ) ⟨ψ, mem_cyclicSubspace_self P ψ⟩ := by sorry
