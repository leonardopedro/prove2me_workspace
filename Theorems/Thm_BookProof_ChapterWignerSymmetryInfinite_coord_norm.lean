-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.coord_norm
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetryInfinite


open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {b : HilbertBasis ι ℂ E} {o : ι}

theorem BookProof.ChapterWignerSymmetryInfinite.coord_norm (hT : IsWignerSymmetry T) (k : ι) (x : E) :
    ‖coord b T o k x‖ = ‖⟪b k, x⟫_ℂ‖ := by sorry
