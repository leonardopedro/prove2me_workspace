-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.inner_T_finset
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_img_expansion_finset
open BookProof.ChapterWignerSymmetryInfinite



open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsWignerSymmetry T) (s : Finset ι) (w : E)
    (hw : ∀ k ∉ s, ⟪b k, w⟫_ℂ = 0) (x : E) :
    ⟪T x, T w⟫_ℂ = ∑ k ∈ s, coord b T o k w * conj (coord b T o k x) := by

  rw [img_expansion_finset hT s w hw, inner_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [inner_smul_right, ← inner_conj_symm (T x) (img b T o k)]
  rfl
