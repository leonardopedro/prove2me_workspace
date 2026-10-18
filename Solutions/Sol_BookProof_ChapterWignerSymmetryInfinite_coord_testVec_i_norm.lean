-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.coord_testVec_i_norm
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Definitions.Def_ChapterOrthogonalSums
import Definitions.Def_ChapterWignerSymmetry
open BookProof.ChapterWignerSymmetryInfinite



open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums
open BookProof.ChapterWignerSymmetry

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) (z : ℂ) :
    ‖coord b T o i (testVec b o i z)‖ = ‖z‖ := by

  rw [coord_norm hT, inner_testVec_i hi]
