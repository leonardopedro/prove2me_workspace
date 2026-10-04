-- Generated from ChapterCyclicDecomposition.lean — theorem BookProof.ChapterCyclicDecomposition.cyclicSubspace_le_orthogonal
import Mathlib
import Definitions.Def_ChapterCyclicDecomposition
import Definitions.Def_ChapterA4
open BookProof.ChapterCyclicDecomposition

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterSpectralMultiplication


theorem BookProof.ChapterCyclicDecomposition.cyclicSubspace_le_orthogonal {M : Submodule ℂ H} (hM : Invariant T hT M) {v : H}
    (hv : v ∈ Mᗮ) : cyclicSubspace T hT v ≤ Mᗮ := by sorry
