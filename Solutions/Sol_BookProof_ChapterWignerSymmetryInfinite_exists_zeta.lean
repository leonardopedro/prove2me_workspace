-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.exists_zeta
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_testVec_o
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_testVec_i
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_left_testVec
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_T_testVec
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_coord_testVec_o_norm
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_coord_testVec_i_norm
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_modulus_add
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
    ∃ zeta : ℂ, (zeta = Complex.I ∨ zeta = -Complex.I) ∧
      ∀ x : E, ‖conj (coord b T o o x) + zeta * conj (coord b T o i x)‖
        = ‖conj ⟪b o, x⟫_ℂ + Complex.I * conj ⟪b i, x⟫_ℂ‖ := by

  set w := testVec b o i Complex.I with hw
  set P := coord b T o o w with hP
  set Q := coord b T o i w with hQ
  have hPnorm : ‖P‖ = 1 := coord_testVec_o_norm hT hi Complex.I
  have hQnorm : ‖Q‖ = 1 := by
    rw [hQ, coord_testVec_i_norm hT hi]
    simp
  have hPP : P * conj P = 1 := by
    rw [Complex.mul_conj]
    have hsq : Complex.normSq P = ‖P‖ ^ 2 := by rw [Complex.sq_norm]
    rw [hsq, hPnorm]; norm_num
  -- the relative phase is `± i`
  have hsum : ‖P + Q‖ = ‖(1 : ℂ) + Complex.I‖ := by
    have h := modulus_add (b := b) hT hi w
    rw [inner_testVec_o hi, inner_testVec_i hi] at h
    exact h
  have hzetanorm : ‖conj P * Q‖ = 1 := by
    rw [norm_mul, Complex.norm_conj, hPnorm, hQnorm, mul_one]
  have hzetare : (conj P * Q).re = 0 := by
    have h1 : ‖P + Q‖ ^ 2 = ‖(1 : ℂ) + Complex.I‖ ^ 2 := by rw [hsum]
    have hP2 : ‖P‖ ^ 2 = 1 := by rw [hPnorm]; norm_num
    have hQ2 : ‖Q‖ ^ 2 = 1 := by rw [hQnorm]; norm_num
    simp only [Complex.sq_norm, Complex.normSq_apply, Complex.add_re, Complex.add_im,
      Complex.one_re, Complex.one_im, Complex.I_re, Complex.I_im] at h1 hP2 hQ2
    simp only [Complex.mul_re, Complex.conj_re, Complex.conj_im]
    nlinarith [h1, hP2, hQ2]
  have hzeta : conj P * Q = Complex.I ∨ conj P * Q = -Complex.I := by
    set z := conj P * Q with hz
    have him : z.im = 1 ∨ z.im = -1 := by
      have h2 : ‖z‖ ^ 2 = z.re ^ 2 + z.im ^ 2 := by
        rw [Complex.sq_norm, Complex.normSq_apply]; ring
      rw [hzetanorm, hzetare] at h2
      have hfac : (z.im - 1) * (z.im + 1) = 0 := by nlinarith
      rcases mul_eq_zero.1 hfac with h | h
      · exact Or.inl (by linarith)
      · exact Or.inr (by linarith)
    rcases him with h | h
    · left; apply Complex.ext <;> simp [hzetare, h]
    · right; apply Complex.ext <;> simp [hzetare, h]
  refine ⟨conj P * Q, hzeta, fun x => ?_⟩
  have hmod := hT x w
  rw [inner_T_testVec hT hi, inner_left_testVec] at hmod
  have hfac : P * conj (coord b T o o x) + Q * conj (coord b T o i x)
      = P * (conj (coord b T o o x) + (conj P * Q) * conj (coord b T o i x)) := by
    calc P * conj (coord b T o o x) + Q * conj (coord b T o i x)
        = P * conj (coord b T o o x) + (P * conj P) * (Q * conj (coord b T o i x)) := by
          rw [hPP]; ring
      _ = P * (conj (coord b T o o x) + (conj P * Q) * conj (coord b T o i x)) := by ring
  rw [hfac, norm_mul, hPnorm, one_mul] at hmod
  exact hmod
