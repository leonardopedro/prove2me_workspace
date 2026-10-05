-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.orthonormal_of_orthCyclicFamily
import Definitions.Def_ChapterPvmMeasure
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
open BookProof.ChapterPvmCyclicDecomposition

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure


theorem BookProof.ChapterPvmCyclicDecomposition.orthonormal_of_orthCyclicFamily {P : Pvm X H} {S : Set H}
    (h : OrthCyclicFamily P S) : Orthonormal ℂ ((↑) : S → H) := by sorry
