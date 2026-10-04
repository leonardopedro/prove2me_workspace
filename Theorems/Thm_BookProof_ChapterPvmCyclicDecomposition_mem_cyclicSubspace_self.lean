-- Generated from ChapterPvmCyclicDecomposition.lean — theorem BookProof.ChapterPvmCyclicDecomposition.mem_cyclicSubspace_self
import Mathlib
import Definitions.Def_ChapterPvmCyclicDecomposition
import Definitions.Def_ChapterA4
open BookProof.ChapterPvmCyclicDecomposition

variable {X : Type*} [MeasurableSpace X]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]


open MeasureTheory
open scoped InnerProductSpace


open BookProof.ChapterPvmMeasure


theorem BookProof.ChapterPvmCyclicDecomposition.mem_cyclicSubspace_self (P : Pvm X H) (ψ : H) : ψ ∈ cyclicSubspace P ψ := by sorry
