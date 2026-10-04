-- Generated from ChapterCyclicDecomposition.lean — theorem BookProof.ChapterCyclicDecomposition.self_mem_cyclicSubspace
import Mathlib
import Definitions.Def_ChapterCyclicDecomposition
import Definitions.Def_ChapterA4
open BookProof.ChapterCyclicDecomposition

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterSpectralMultiplication


theorem BookProof.ChapterCyclicDecomposition.self_mem_cyclicSubspace (xi : H) : xi ∈ cyclicSubspace T hT xi := by sorry
