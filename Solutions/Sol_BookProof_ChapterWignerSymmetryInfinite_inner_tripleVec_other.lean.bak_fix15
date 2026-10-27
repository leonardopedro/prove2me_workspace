-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.inner_tripleVec_other
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
theorem solution (z : ℂ) {k : ι} (hk : k ∉ ({o, i, j} : Finset ι)) :
    ⟪b k, tripleVec b o i j z⟫_ℂ = 0 := by

  simp only [Finset.mem_insert, Finset.mem_singleton, not_or] at hk
  rw [tripleVec, inner_add_right, inner_add_right, inner_smul_right, inner_smul_right,
    inner_basis_eq k o, inner_basis_eq k i, inner_basis_eq k j, if_neg hk.1, if_neg hk.2.1,
    if_neg hk.2.2]
  ring
