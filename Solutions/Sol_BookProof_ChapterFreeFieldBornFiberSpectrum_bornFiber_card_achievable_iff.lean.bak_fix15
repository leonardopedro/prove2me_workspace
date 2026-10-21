-- Generated from ChapterFreeFieldBornFiberSpectrum.lean — solution of BookProof.ChapterFreeFieldBornFiberSpectrum.bornFiber_card_achievable_iff
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberSpectrum
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberSpectrum_bornFiber_card_isPowerOfTwo
import Theorems.Thm_BookProof_ChapterFreeFieldBornFiberSpectrum_exists_bornFiber_card_eq_two_pow
open BookProof.ChapterFreeFieldBornFiberSpectrum



open MeasureTheory
open BookProof.ChapterFreeFieldBorn BookProof.ChapterFreeFieldBornSurj
open BookProof.ChapterFreeFieldBornCont BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberTwo
open BookProof.ChapterFreeFieldBornFiberBounds


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {c : ℕ} :
    (∃ p : ↥(stdSimplex ℝ (Fin n)), Nat.card ↥(bornMapSphere n ⁻¹' {p}) = c) ↔
      ∃ k, 1 ≤ k ∧ k ≤ n ∧ c = 2 ^ k := by

  constructor
  · rintro ⟨p, rfl⟩
    obtain ⟨k, hk₁, hk₂, hk⟩ := bornFiber_card_isPowerOfTwo (p := p)
    exact ⟨k, hk₁, hk₂, hk⟩
  · rintro ⟨k, hk₁, hk₂, rfl⟩
    exact exists_bornFiber_card_eq_two_pow hk₁ hk₂
