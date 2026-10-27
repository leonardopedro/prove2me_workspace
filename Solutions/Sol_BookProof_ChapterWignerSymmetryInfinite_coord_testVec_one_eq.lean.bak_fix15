-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.coord_testVec_one_eq
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_phase_self
open BookProof.ChapterWignerSymmetryInfinite



open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsWignerSymmetry T) {i : ι} (hi : i ≠ o) :
    coord b T o o (testVec b o i 1) = coord b T o i (testVec b o i 1) := by

  have hw : testVec b o i 1 = b o + b i := by rw [testVec, one_smul]
  set A := ⟪T (b o), T (b o + b i)⟫_ℂ with hA
  set B := ⟪T (b i), T (b o + b i)⟫_ℂ with hB
  have hAnorm : ‖A‖ = 1 := inner_pair_left_norm hT hi
  have hBnorm : ‖B‖ = 1 := inner_pair_right_norm hT hi
  have hAA : A * conj A = 1 := by
    rw [Complex.mul_conj]
    have hsq : Complex.normSq A = ‖A‖ ^ 2 := by rw [Complex.sq_norm]
    rw [hsq, hAnorm]; norm_num
  have hBB : B * conj B = 1 := by
    rw [Complex.mul_conj]
    have hsq : Complex.normSq B = ‖B‖ ^ 2 := by rw [Complex.sq_norm]
    rw [hsq, hBnorm]; norm_num
  have hA0 : conj A ≠ 0 := by
    intro h0
    rw [h0, mul_zero] at hAA
    exact zero_ne_one hAA
  have hleft : coord b T o o (testVec b o i 1) = A := by
    rw [coord, img, phase_self, hw, one_smul]
  have hright : coord b T o i (testVec b o i 1) = conj (B / A) * B := by
    rw [coord, img, phase, if_neg hi, inner_smul_left, hw]
  rw [hleft, hright, map_div₀]
  field_simp
  linear_combination hAA - hBB
