-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.inner_tripleVec_j
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
open BookProof.ChapterWignerSymmetryInfinite



open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}

set_option maxHeartbeats 1000000 in
theorem solution (hij : i ≠ j) (hjo : j ≠ o) (z : ℂ) :
    ⟪b j, tripleVec b o i j z⟫_ℂ = z := by

  rw [tripleVec, inner_add_right, inner_add_right, inner_smul_right, inner_smul_right,
    inner_basis_eq j o, inner_basis_eq j i, inner_basis_eq j j, if_pos rfl, if_neg hjo,
    if_neg (Ne.symm hij)]
  ring
