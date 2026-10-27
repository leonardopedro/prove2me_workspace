-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.modulus_add
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_left_testVec
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_T_testVec
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_coord_testVec_o_norm
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_coord_testVec_one_eq
open BookProof.ChapterWignerSymmetryInfinite



open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) (x : E) :
    ‖coord b T o o x + coord b T o i x‖ = ‖⟪b o, x⟫_ℂ + ⟪b i, x⟫_ℂ‖ := by

  have hmod := hT x (testVec b o i 1)
  rw [inner_T_testVec hT hi, ← coord_testVec_one_eq hT hi, inner_left_testVec] at hmod
  set P := coord b T o o (testVec b o i 1) with hP
  have hPnorm : ‖P‖ = 1 := coord_testVec_o_norm hT hi 1
  have hfac : P * conj (coord b T o o x) + P * conj (coord b T o i x)
      = P * conj (coord b T o o x + coord b T o i x) := by
    rw [map_add]; ring
  rw [hfac, norm_mul, hPnorm, one_mul, Complex.norm_conj] at hmod
  rw [hmod, one_mul, ← map_add, Complex.norm_conj]
