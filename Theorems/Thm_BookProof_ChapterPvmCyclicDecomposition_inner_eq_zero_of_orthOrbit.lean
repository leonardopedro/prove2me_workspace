-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.inner_eq_zero_of_orthOrbit
import Definitions.Def_ChapterPvmMeasure
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
open BookProof.ChapterPvmCyclicDecomposition


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


theorem BookProof.ChapterPvmCyclicDecomposition.inner_eq_zero_of_orthOrbit {P : Pvm X H} {ψ φ : H} (h : OrthOrbit P ψ φ) :
    ⟪ψ, φ⟫_ℂ = 0 := by sorry
