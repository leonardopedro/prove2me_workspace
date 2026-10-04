-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.restrictCyclic_apply
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterA4
open BookProof.ChapterPvmCyclicDecomposition

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure


theorem BookProof.ChapterPvmCyclicDecomposition.restrictCyclic_apply [CompleteSpace H] (P : Pvm X H) (ψ : H)
    {E : Set X} (hE : MeasurableSet E) (v : cyclicSubspace P ψ) :
    (((restrictCyclic P ψ).p E v : cyclicSubspace P ψ) : H) = P.p E (v : H) := by sorry
