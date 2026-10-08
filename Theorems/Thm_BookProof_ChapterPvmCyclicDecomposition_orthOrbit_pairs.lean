-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.orthOrbit_pairs
import Definitions.Def_ChapterPvmMeasure
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
open BookProof.ChapterPvmCyclicDecomposition


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


theorem BookProof.ChapterPvmCyclicDecomposition.orthOrbit_pairs {P : Pvm X H} {ψ φ : H} (h : OrthOrbit P ψ φ)
    {E F : Set X} (hE : MeasurableSet E) (hF : MeasurableSet F) :
    ⟪P.p E ψ, P.p F φ⟫_ℂ = 0 := by sorry
