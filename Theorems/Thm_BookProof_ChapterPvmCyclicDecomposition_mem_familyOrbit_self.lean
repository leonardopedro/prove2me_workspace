-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.mem_familyOrbit_self
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterA4
open BookProof.ChapterPvmCyclicDecomposition

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure


theorem BookProof.ChapterPvmCyclicDecomposition.mem_familyOrbit_self {P : Pvm X H} {S : Set H} {ψ : H} (hψ : ψ ∈ S) :
    ψ ∈ familyOrbit P S := by sorry
