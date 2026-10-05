-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.coord_of_key
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_coord_norm
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_coord_eq_zero
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_eq_smul_of_hasSum_norm
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_coord_of_key_ne_zero
open BookProof.ChapterWignerSymmetryInfinite



open scoped InnerProductSpace ComplexConjugate


open BookProof.ChapterWignerSymmetry BookProof.ChapterOrthogonalSums

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}

variable {ι : Type*} [DecidableEq ι] {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
  [CompleteSpace E] {T : E → E}
variable {b : HilbertBasis ι ℂ E} {o : ι}
variable {i j : ι}
variable (κ : ℂ →+* ℂ)

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsWignerSymmetry T) (hκn : ∀ z, ‖κ z‖ = ‖z‖)
    (hκc : ∀ z, κ (conj z) = conj (κ z))
    (hkey : ∀ i, i ≠ o → ∀ x : E,
      conj (coord b T o o x) * coord b T o i x = κ (conj ⟪b o, x⟫_ℂ * ⟪b i, x⟫_ℂ))
    (x : E) : ∃ lam : ℂ, ‖lam‖ = 1 ∧ ∀ k, coord b T o k x = lam * κ ⟪b k, x⟫_ℂ := by

  by_cases hxo : ⟪b o, x⟫_ℂ = 0
  swap
  · exact coord_of_key_ne_zero κ hT hκn hκc hkey hxo
  by_cases hx0 : x = 0
  · refine ⟨1, by norm_num, fun k => ?_⟩
    have hzero : ⟪b k, x⟫_ℂ = 0 := by rw [hx0, inner_zero_right]
    rw [hzero, _root_.map_zero, mul_zero]
    exact coord_eq_zero hT hzero
  -- the pivot coordinate vanishes: compare with `x + b o`
  have hxnorm : (0 : ℝ) < ‖x‖ := norm_pos_iff.2 hx0
  set y := x + b o with hy
  have hyo : ⟪b o, y⟫_ℂ = 1 := by
    rw [hy, inner_add_right, hxo, inner_basis_eq o o, if_pos rfl]
    ring
  have hyk : ∀ k, k ≠ o → ⟪b k, y⟫_ℂ = ⟪b k, x⟫_ℂ := by
    intro k hk
    rw [hy, inner_add_right, inner_basis_eq k o, if_neg hk]
    ring
  obtain ⟨mu, hmunorm, hmu⟩ :=
    coord_of_key_ne_zero κ hT hκn hκc hkey (x := y) (by rw [hyo]; exact one_ne_zero)
  have hcox : coord b T o o x = 0 := coord_eq_zero hT hxo
  have hmuconj : conj mu * mu = 1 := by
    rw [mul_comm, Complex.mul_conj]
    have hsq : Complex.normSq mu = ‖mu‖ ^ 2 := by rw [Complex.sq_norm]
    rw [hsq, hmunorm]; norm_num
  -- the amplitude between `T x` and `T y`, in coordinates
  have hinner : HasSum (fun k => coord b T o k y * conj (coord b T o k x)) ⟪T x, T y⟫_ℂ := by
    have h := (hasSum_img_expansion (b := b) (o := o) hT y).mapL (innerSL ℂ (T x))
    have hterm : ∀ k : ι, ⟪T x, ⟪img b T o k, T y⟫_ℂ • img b T o k⟫_ℂ
        = coord b T o k y * conj (coord b T o k x) := by
      intro k
      rw [inner_smul_right, ← inner_conj_symm (T x) (img b T o k)]
      rfl
    simpa only [innerSL_apply_apply, hterm] using h
  have hz : HasSum (fun k => κ ⟪b k, x⟫_ℂ * conj (coord b T o k x))
      (conj mu * ⟪T x, T y⟫_ℂ) := by
    have h := hinner.mul_left (conj mu)
    have hterm : ∀ k : ι, conj mu * (coord b T o k y * conj (coord b T o k x))
        = κ ⟪b k, x⟫_ℂ * conj (coord b T o k x) := by
      intro k
      by_cases hk : k = o
      · subst hk
        rw [hcox]
        simp
      · rw [hmu k, hyk k hk]
        calc conj mu * (mu * κ ⟪b k, x⟫_ℂ * conj (coord b T o k x))
            = (conj mu * mu) * (κ ⟪b k, x⟫_ℂ * conj (coord b T o k x)) := by ring
          _ = κ ⟪b k, x⟫_ℂ * conj (coord b T o k x) := by rw [hmuconj]; ring
    simpa only [hterm] using h
  have hnormz : ∀ k : ι, ‖κ ⟪b k, x⟫_ℂ * conj (coord b T o k x)‖ = ‖⟪b k, x⟫_ℂ‖ ^ 2 := by
    intro k
    rw [norm_mul, hκn, Complex.norm_conj, coord_norm hT]
    ring
  have hnsum : HasSum (fun k => ‖κ ⟪b k, x⟫_ℂ * conj (coord b T o k x)‖) (‖x‖ ^ 2) := by
    simpa only [hnormz] using hasSum_basis_norm_sq (b := b) x
  have hinnerxy : ⟪x, y⟫_ℂ = ((‖x‖ ^ 2 : ℝ) : ℂ) := by
    rw [hy, inner_add_right, inner_self_eq_norm_sq_to_K, ← inner_conj_symm x (b o), hxo]
    simp
  have hSnorm : ‖conj mu * ⟪T x, T y⟫_ℂ‖ = ‖x‖ ^ 2 := by
    rw [norm_mul, Complex.norm_conj, hmunorm, one_mul, hT x y, hinnerxy, Complex.norm_real,
      Real.norm_of_nonneg (by positivity)]
  have hSne : conj mu * ⟪T x, T y⟫_ℂ ≠ 0 := by
    intro h0
    rw [h0, norm_zero] at hSnorm
    nlinarith [hSnorm, hxnorm]
  have hnsum' : HasSum (fun k => ‖κ ⟪b k, x⟫_ℂ * conj (coord b T o k x)‖)
      ‖conj mu * ⟪T x, T y⟫_ℂ‖ := by rw [hSnorm]; exact hnsum
  set S := conj mu * ⟪T x, T y⟫_ℂ with hS
  set omega := S / ((‖S‖ : ℝ) : ℂ) with homega
  have homeganorm : ‖omega‖ = 1 := by
    rw [homega, norm_div, Complex.norm_real, Real.norm_of_nonneg (norm_nonneg S),
      div_self (by simpa using hSne)]
  refine ⟨conj omega, by rw [Complex.norm_conj, homeganorm], fun k => ?_⟩
  have hterm := eq_smul_of_hasSum_norm hz hnsum' hSne k
  by_cases hak : ⟪b k, x⟫_ℂ = 0
  · rw [hak, _root_.map_zero, mul_zero]
    exact coord_eq_zero hT hak
  · have hκa : κ ⟪b k, x⟫_ℂ ≠ 0 := by
      intro h
      apply hak
      have hn := hκn ⟪b k, x⟫_ℂ
      rw [h, norm_zero] at hn
      exact norm_eq_zero.1 hn.symm
    have hprod : conj (κ ⟪b k, x⟫_ℂ) * κ ⟪b k, x⟫_ℂ
        = ((‖κ ⟪b k, x⟫_ℂ * conj (coord b T o k x)‖ : ℝ) : ℂ) := by
      have h1 : Complex.normSq (κ ⟪b k, x⟫_ℂ) = Complex.normSq ⟪b k, x⟫_ℂ := by
        rw [← Complex.sq_norm, ← Complex.sq_norm, hκn]
      rw [hnormz k, mul_comm, Complex.mul_conj, h1, Complex.sq_norm]
    have hconj := congrArg (starRingEnd ℂ) hterm
    rw [map_mul, map_mul, Complex.conj_conj, Complex.conj_ofReal] at hconj
    -- `conj (κ a) * c = conj omega * ‖z k‖`
    have hne : conj (κ ⟪b k, x⟫_ℂ) ≠ 0 := by simpa using hκa
    refine mul_left_cancel₀ hne ?_
    rw [hconj, ← hprod, ← homega]
    ring
