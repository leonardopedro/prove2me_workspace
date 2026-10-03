-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.sum_triple
import Definitions.Def_ChapterWignerSymmetry
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterA4

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}


open scoped InnerProductSpace ComplexConjugate




theorem BookProof.ChapterWignerSymmetryInfinite.sum_triple (hio : i ≠ o) (hjo : j ≠ o) (hij : i ≠ j) (f : ι → ℂ) :
    ∑ k ∈ ({o, i, j} : Finset ι), f k = f o + f i + f j := by sorry
