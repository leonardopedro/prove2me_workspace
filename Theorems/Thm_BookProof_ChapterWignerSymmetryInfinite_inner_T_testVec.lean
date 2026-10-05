-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.inner_T_testVec
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetryInfinite

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}


open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums


theorem BookProof.ChapterWignerSymmetryInfinite.inner_T_testVec (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) (z : ℂ) (x : E) :
    ⟪T x, T (testVec b o i z)⟫_ℂ
      = coord b T o o (testVec b o i z) * conj (coord b T o o x)
        + coord b T o i (testVec b o i z) * conj (coord b T o i x) := by sorry
