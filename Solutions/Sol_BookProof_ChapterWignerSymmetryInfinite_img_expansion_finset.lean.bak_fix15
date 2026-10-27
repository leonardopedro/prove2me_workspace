-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.img_expansion_finset
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_coord_eq_zero
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
    (hw : ∀ k ∉ s, ⟪b k, w⟫_ℂ = 0) :
    T w = ∑ k ∈ s, coord b T o k w • img b T o k := by

  have h1 : HasSum (fun k => coord b T o k w • img b T o k) (T w) := hasSum_img_expansion hT w
  have h2 : HasSum (fun k => coord b T o k w • img b T o k)
      (∑ k ∈ s, coord b T o k w • img b T o k) := by
    refine hasSum_sum_of_ne_finset_zero ?_
    intro k hk
    rw [coord_eq_zero hT (hw k hk), zero_smul]
  exact h1.unique h2
