-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.inner_T_testVec
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_T_finset
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_testVec_other
open BookProof.ChapterWignerSymmetryInfinite



open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) (z : ℂ) (x : E) :
    ⟪T x, T (testVec b o i z)⟫_ℂ
      = coord b T o o (testVec b o i z) * conj (coord b T o o x)
        + coord b T o i (testVec b o i z) * conj (coord b T o i x) := by

  rw [inner_T_finset hT ({o, i} : Finset ι) _ (fun k hk => inner_testVec_other z hk) x,
    Finset.sum_pair (Ne.symm hi)]
