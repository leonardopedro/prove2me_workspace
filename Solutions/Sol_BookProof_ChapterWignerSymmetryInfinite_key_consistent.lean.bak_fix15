-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.key_consistent
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_coord_norm
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_T_finset
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_tripleVec_o
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_tripleVec_i
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_tripleVec_j
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_tripleVec_other
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_inner_left_tripleVec
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_sum_triple
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
theorem solution (hT : IsWignerSymmetry T) (hio : i ≠ o) (hjo : j ≠ o) (hij : i ≠ j)
    (hlin : ∀ x : E, conj (coord b T o o x) * coord b T o i x = conj ⟪b o, x⟫_ℂ * ⟪b i, x⟫_ℂ)
    (hanti : ∀ x : E, conj (coord b T o o x) * coord b T o j x
      = conj (conj ⟪b o, x⟫_ℂ * ⟪b j, x⟫_ℂ)) : False := by

  have hcancel : ∀ P c z : ℂ, P * conj P = 1 → conj P * c = z → c = P * z := by
    intro P c z hPP h
    calc c = (P * conj P) * c := by rw [hPP]; ring
      _ = P * (conj P * c) := by ring
      _ = P * z := by rw [h]
  have hunit : ∀ P : ℂ, ‖P‖ = 1 → P * conj P = 1 := by
    intro P hP
    rw [Complex.mul_conj]
    have hsq : Complex.normSq P = ‖P‖ ^ 2 := by rw [Complex.sq_norm]
    rw [hsq, hP]; norm_num
  set v := tripleVec b o i j 1 with hv
  set w := tripleVec b o i j Complex.I with hw
  have hvo : ⟪b o, v⟫_ℂ = 1 := inner_tripleVec_o hio hjo 1
  have hvi0 : ⟪b i, v⟫_ℂ = 1 := inner_tripleVec_i hio hij 1
  have hvj0 : ⟪b j, v⟫_ℂ = 1 := inner_tripleVec_j hij hjo 1
  have hwo : ⟪b o, w⟫_ℂ = 1 := inner_tripleVec_o hio hjo Complex.I
  have hwi0 : ⟪b i, w⟫_ℂ = Complex.I := inner_tripleVec_i hio hij Complex.I
  have hwj0 : ⟪b j, w⟫_ℂ = Complex.I := inner_tripleVec_j hij hjo Complex.I
  have hpnorm : ‖coord b T o o v‖ = 1 := by rw [coord_norm hT, hvo]; simp
  have hqnorm : ‖coord b T o o w‖ = 1 := by rw [coord_norm hT, hwo]; simp
  have hpp := hunit _ hpnorm
  have hqq := hunit _ hqnorm
  -- the coordinates of the two images
  have hvi : coord b T o i v = coord b T o o v * 1 := by
    refine hcancel _ _ _ hpp ?_
    rw [hlin v, hvo, hvi0]
    simp
  have hvj : coord b T o j v = coord b T o o v * 1 := by
    refine hcancel _ _ _ hpp ?_
    rw [hanti v, hvo, hvj0]
    simp
  have hwi : coord b T o i w = coord b T o o w * Complex.I := by
    refine hcancel _ _ _ hqq ?_
    rw [hlin w, hwo, hwi0]
    simp
  have hwj : coord b T o j w = coord b T o o w * (-Complex.I) := by
    refine hcancel _ _ _ hqq ?_
    rw [hanti w, hwo, hwj0]
    simp
  -- compare the two transition probabilities
  have hmod := hT v w
  rw [inner_T_finset hT ({o, i, j} : Finset ι) w
      (fun k hk => inner_tripleVec_other Complex.I hk) v,
    sum_triple hio hjo hij, inner_left_tripleVec, hvo, hvi0, hvj0, hvi, hvj, hwi, hwj] at hmod
  have hleft : coord b T o o w * conj (coord b T o o v)
      + coord b T o o w * Complex.I * conj (coord b T o o v * 1)
      + coord b T o o w * -Complex.I * conj (coord b T o o v * 1)
      = coord b T o o w * conj (coord b T o o v) := by
    rw [map_mul, map_one]
    ring
  rw [hleft, norm_mul, Complex.norm_conj, hpnorm, hqnorm, mul_one] at hmod
  have h5 : ‖conj (1 : ℂ) + Complex.I * conj (1 : ℂ) + Complex.I * conj (1 : ℂ)‖ ^ 2 = 5 := by
    simp [Complex.sq_norm, Complex.normSq_apply]
    norm_num
  rw [← hmod] at h5
  norm_num at h5
