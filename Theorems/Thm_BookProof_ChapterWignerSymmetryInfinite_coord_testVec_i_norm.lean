-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.coord_testVec_i_norm
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterWignerSymmetry
import Definitions.Def_ChapterA4
open BookProof.ChapterWignerSymmetry

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}


open scoped InnerProductSpace ComplexConjugate




theorem BookProof.ChapterWignerSymmetryInfinite.coord_testVec_i_norm (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) (z : ℂ) :
    ‖coord b T o i (testVec b o i z)‖ = ‖z‖ := by sorry
