-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.pvmMeasure_restrictCyclic
import Definitions.Def_ChapterPvmMeasure
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
open BookProof.ChapterPvmCyclicDecomposition

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure


theorem BookProof.ChapterPvmCyclicDecomposition.pvmMeasure_restrictCyclic [CompleteSpace H] (P : Pvm X H) (ψ : H) :
    pvmMeasure (restrictCyclic P ψ) ⟨ψ, mem_cyclicSubspace_self P ψ⟩ = pvmMeasure P ψ := by sorry
