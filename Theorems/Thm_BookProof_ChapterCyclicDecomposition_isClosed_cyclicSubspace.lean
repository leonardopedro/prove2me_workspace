-- Generated from ChapterCyclicDecomposition.lean — theorem BookProof.ChapterCyclicDecomposition.isClosed_cyclicSubspace
import Mathlib
import Definitions.Def_ChapterCyclicDecomposition
import Definitions.Def_ChapterA4
open BookProof.ChapterCyclicDecomposition

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterSpectralMultiplication


theorem BookProof.ChapterCyclicDecomposition.isClosed_cyclicSubspace (xi : H) : IsClosed (cyclicSubspace T hT xi : Set H) := by sorry
