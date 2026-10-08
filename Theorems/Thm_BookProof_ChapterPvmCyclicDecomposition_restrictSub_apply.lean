-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.restrictSub_apply
import Definitions.Def_ChapterPvmMeasure
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
open BookProof.ChapterPvmCyclicDecomposition


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


theorem BookProof.ChapterPvmCyclicDecomposition.restrictSub_apply (P : Pvm X H) (V : Submodule ℂ H) [CompleteSpace V]
    (hV : ∀ E : Set X, MeasurableSet E → ∀ v ∈ V, P.p E v ∈ V) {E : Set X}
    (hE : MeasurableSet E) (v : V) :
    (((restrictSub P V hV).p E v : V) : H) = P.p E (v : H) := by sorry
