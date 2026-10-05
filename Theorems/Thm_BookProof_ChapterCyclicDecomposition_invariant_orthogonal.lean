-- Generated from ChapterCyclicDecomposition.lean — theorem BookProof.ChapterCyclicDecomposition.invariant_orthogonal
import Definitions.Def_ChapterSpectralMultiplication
import Mathlib
import Definitions.Def_ChapterCyclicDecomposition
open BookProof.ChapterCyclicDecomposition

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterSpectralMultiplication


theorem BookProof.ChapterCyclicDecomposition.invariant_orthogonal {M : Submodule ℂ H} (hM : Invariant T hT M) :
    Invariant T hT Mᗮ := by sorry
