-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.inner_tripleVec_i
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
theorem solution (hio : i ≠ o) (hij : i ≠ j) (z : ℂ) :
    ⟪b i, tripleVec b o i j z⟫_ℂ = z := by

  rw [tripleVec, inner_add_right, inner_add_right, inner_smul_right, inner_smul_right,
    inner_basis_eq i o, inner_basis_eq i i, inner_basis_eq i j, if_pos rfl, if_neg hij,
    if_neg hio]
  ring
