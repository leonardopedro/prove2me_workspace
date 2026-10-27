-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.coord_of_key_ne_zero
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_coord_norm
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
    {x : E} (hx : ⟪b o, x⟫_ℂ ≠ 0) :
    ∃ lam : ℂ, ‖lam‖ = 1 ∧ ∀ k, coord b T o k x = lam * κ ⟪b k, x⟫_ℂ := by

  have hκx : κ ⟪b o, x⟫_ℂ ≠ 0 := by
    intro h
    apply hx
    have hn := hκn ⟪b o, x⟫_ℂ
    rw [h, norm_zero] at hn
    exact norm_eq_zero.1 hn.symm
  refine ⟨coord b T o o x / κ ⟪b o, x⟫_ℂ, ?_, ?_⟩
  · rw [norm_div, coord_norm hT, hκn]
    exact div_self (by simpa using hx)
  · intro k
    have hlam : coord b T o o x = (coord b T o o x / κ ⟪b o, x⟫_ℂ) * κ ⟪b o, x⟫_ℂ := by
      field_simp
    have hlamnorm : (coord b T o o x / κ ⟪b o, x⟫_ℂ) * conj (coord b T o o x / κ ⟪b o, x⟫_ℂ)
        = 1 := by
      rw [Complex.mul_conj]
      have hsq : Complex.normSq (coord b T o o x / κ ⟪b o, x⟫_ℂ)
          = ‖coord b T o o x / κ ⟪b o, x⟫_ℂ‖ ^ 2 := by rw [Complex.sq_norm]
      rw [hsq, norm_div, coord_norm hT, hκn, div_self (by simpa using hx)]
      norm_num
    by_cases hk : k = o
    · subst hk; exact hlam
    · have h := hkey k hk x
      rw [map_mul, hκc] at h
      have hconj : conj (coord b T o o x)
          = conj (coord b T o o x / κ ⟪b o, x⟫_ℂ) * conj (κ ⟪b o, x⟫_ℂ) := by
        rw [← map_mul, ← hlam]
      rw [hconj] at h
      have hne : conj (κ ⟪b o, x⟫_ℂ) ≠ 0 := by simpa using hκx
      have hcancel : conj (coord b T o o x / κ ⟪b o, x⟫_ℂ) * coord b T o k x = κ ⟪b k, x⟫_ℂ := by
        refine mul_left_cancel₀ hne ?_
        calc conj (κ ⟪b o, x⟫_ℂ) * (conj (coord b T o o x / κ ⟪b o, x⟫_ℂ) * coord b T o k x)
            = conj (coord b T o o x / κ ⟪b o, x⟫_ℂ) * conj (κ ⟪b o, x⟫_ℂ) * coord b T o k x := by
              ring
          _ = conj (κ ⟪b o, x⟫_ℂ) * κ ⟪b k, x⟫_ℂ := h
      calc coord b T o k x
          = ((coord b T o o x / κ ⟪b o, x⟫_ℂ) * conj (coord b T o o x / κ ⟪b o, x⟫_ℂ))
            * coord b T o k x := by rw [hlamnorm]; ring
        _ = (coord b T o o x / κ ⟪b o, x⟫_ℂ)
            * (conj (coord b T o o x / κ ⟪b o, x⟫_ℂ) * coord b T o k x) := by ring
        _ = (coord b T o o x / κ ⟪b o, x⟫_ℂ) * κ ⟪b k, x⟫_ℂ := by rw [hcancel]
