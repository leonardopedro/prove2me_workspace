-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.inner_tripleVec_o
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

theorem BookProof.ChapterWignerSymmetryInfinite.inner_tripleVec_o (hio : i ≠ o) (hjo : j ≠ o) (z : ℂ) :
    ⟪b o, tripleVec b o i j z⟫_ℂ = 1 := by sorry
