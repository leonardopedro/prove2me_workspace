-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.orthOrbit_pairs
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterA4
open BookProof.ChapterPvmCyclicDecomposition

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure


theorem BookProof.ChapterPvmCyclicDecomposition.orthOrbit_pairs {P : Pvm X H} {ψ φ : H} (h : OrthOrbit P ψ φ)
    {E F : Set X} (hE : MeasurableSet E) (hF : MeasurableSet F) :
    ⟪P.p E ψ, P.p F φ⟫_ℂ = 0 := by sorry
