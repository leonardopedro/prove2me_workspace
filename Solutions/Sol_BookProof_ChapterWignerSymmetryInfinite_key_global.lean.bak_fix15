-- Generated from ChapterWignerSymmetryInfinite.lean — solution of BookProof.ChapterWignerSymmetryInfinite.key_global
import Mathlib
import Definitions.Def_ChapterWignerSymmetryInfinite
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_key_pair
import Theorems.Thm_BookProof_ChapterWignerSymmetryInfinite_key_consistent
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
theorem solution (hT : IsWignerSymmetry T) :
    (∀ i, i ≠ o → ∀ x : E,
      conj (coord b T o o x) * coord b T o i x = conj ⟪b o, x⟫_ℂ * ⟪b i, x⟫_ℂ) ∨
    (∀ i, i ≠ o → ∀ x : E,
      conj (coord b T o o x) * coord b T o i x = conj (conj ⟪b o, x⟫_ℂ * ⟪b i, x⟫_ℂ)) := by

  by_cases hex : ∃ i₀, i₀ ≠ o ∧ ∀ x : E,
      conj (coord b T o o x) * coord b T o i₀ x = conj ⟪b o, x⟫_ℂ * ⟪b i₀, x⟫_ℂ
  · obtain ⟨i₀, hi₀, hkey₀⟩ := hex
    left
    intro k hk x
    rcases key_pair hT hk with h | h
    · exact h x
    · by_cases hki : k = i₀
      · subst hki; exact hkey₀ x
      · exact (key_consistent hT hi₀ hk (fun e => hki e.symm) hkey₀ h).elim
  · push_neg at hex
    right
    intro k hk x
    rcases key_pair hT hk with h | h
    · obtain ⟨x₀, hx₀⟩ := hex k hk
      exact absurd (h x₀) hx₀
    · exact h x
