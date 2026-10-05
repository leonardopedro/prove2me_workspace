-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.inner_tripleVec_other
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
open BookProof.ChapterWignerSymmetryInfinite

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}


open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums


theorem BookProof.ChapterWignerSymmetryInfinite.inner_tripleVec_other (z : ℂ) {k : ι} (hk : k ∉ ({o, i, j} : Finset ι)) :
    ⟪b k, tripleVec b o i j z⟫_ℂ = 0 := by sorry
