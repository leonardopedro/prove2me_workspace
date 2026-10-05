-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.inner_T_finset
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


theorem BookProof.ChapterWignerSymmetryInfinite.inner_T_finset (hT : IsWignerSymmetry T) (s : Finset ι) (w : E)
    (hw : ∀ k ∉ s, ⟪b k, w⟫_ℂ = 0) (x : E) :
    ⟪T x, T w⟫_ℂ = ∑ k ∈ s, coord b T o k w * conj (coord b T o k x) := by sorry
