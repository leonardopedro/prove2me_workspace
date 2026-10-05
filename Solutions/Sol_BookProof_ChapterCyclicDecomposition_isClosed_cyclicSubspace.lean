-- Generated from ChapterCyclicDecomposition.lean — solution of BookProof.ChapterCyclicDecomposition.isClosed_cyclicSubspace
import Mathlib
import Definitions.Def_ChapterCyclicDecomposition
open BookProof.ChapterCyclicDecomposition



noncomputable section

open MeasureTheory Complex


open BookProof.ChapterSpectralMultiplication

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)

set_option maxHeartbeats 1000000 in
theorem solution (xi : H) : IsClosed (cyclicSubspace T hT xi : Set H) := Submodule.isClosed_topologicalClosure _
