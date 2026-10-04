-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.restrictSub_apply
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterA4
open BookProof.ChapterPvmCyclicDecomposition

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure


theorem BookProof.ChapterPvmCyclicDecomposition.restrictSub_apply (P : Pvm X H) (V : Submodule ℂ H) [CompleteSpace V]
    (hV : ∀ E : Set X, MeasurableSet E → ∀ v ∈ V, P.p E v ∈ V) {E : Set X}
    (hE : MeasurableSet E) (v : V) :
    (((restrictSub P V hV).p E v : V) : H) = P.p E (v : H) := by sorry
