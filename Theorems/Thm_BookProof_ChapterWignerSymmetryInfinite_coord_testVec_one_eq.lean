-- Generated from ChapterWignerSymmetryInfinite.lean — theorem BookProof.ChapterWignerSymmetryInfinite.coord_testVec_one_eq
import Definitions.Def_ChapterOrthogonalSums
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterNsLagrangianDetConvolution
import Definitions.Def_ChapterWignerSymmetry
open BookProof.NsLagrangianDet
open BookProof.ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetryInfinite

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}


open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums


theorem BookProof.ChapterWignerSymmetryInfinite.coord_testVec_one_eq (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) :
    coord b T o o (testVec b o i 1) = coord b T o i (testVec b o i 1) := by sorry
