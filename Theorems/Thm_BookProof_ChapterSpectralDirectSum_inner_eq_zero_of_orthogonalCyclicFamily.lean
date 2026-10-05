-- Generated from ChapterSpectralDirectSum.lean — theorem BookProof.ChapterSpectralDirectSum.inner_eq_zero_of_orthogonalCyclicFamily
import Definitions.Def_ChapterAbelianGelfandModel
import Definitions.Def_ChapterSpectralMultiplication
import Definitions.Def_ChapterCyclicDecomposition
import Definitions.Def_ChapterCyclicDirectSum
import Mathlib
import Definitions.Def_ChapterSpectralDirectSum
open BookProof.ChapterSpectralDirectSum

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (T : H →L[ℂ] H) (hT : IsStarNormal T) (xi : H)


noncomputable section

open MeasureTheory Complex


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterSpectralMultiplication
open BookProof.ChapterCyclicDecomposition BookProof.ChapterCyclicDirectSum


theorem BookProof.ChapterSpectralDirectSum.inner_eq_zero_of_orthogonalCyclicFamily {S : Set H} (hS : OrthogonalCyclicFamily T hT S)
    {x y : H} (hx : x ∈ S) (hy : y ∈ S) (hxy : x ≠ y) : inner ℂ x y = (0 : ℂ) := by sorry
