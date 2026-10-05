-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.inner_left_tripleVec
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
theorem solution (z : ℂ) (x : E) :
    ⟪x, tripleVec b o i j z⟫_ℂ
      = conj ⟪b o, x⟫_ℂ + z * conj ⟪b i, x⟫_ℂ + z * conj ⟪b j, x⟫_ℂ := by

  rw [tripleVec, inner_add_right, inner_add_right, inner_smul_right, inner_smul_right,
    ← inner_conj_symm x (b o), ← inner_conj_symm x (b i), ← inner_conj_symm x (b j)]
