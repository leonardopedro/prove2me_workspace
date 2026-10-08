-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.sum_triple
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
open BookProof.ChapterWignerSymmetryInfinite


open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}

theorem BookProof.ChapterWignerSymmetryInfinite.sum_triple (hio : i ≠ o) (hjo : j ≠ o) (hij : i ≠ j) (f : ι → ℂ) :
    ∑ k ∈ ({o, i, j} : Finset ι), f k = f o + f i + f j := by sorry
