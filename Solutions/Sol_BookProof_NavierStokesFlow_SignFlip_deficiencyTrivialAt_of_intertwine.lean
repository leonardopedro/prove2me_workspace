-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.deficiencyTrivialAt_of_intertwine
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (U : F ≃ₗᵢ[ℂ] F) (T T' : D →ₗ[ℂ] F)
    (hU : ∀ v : D, U (v : F) ∈ D)
    (hcomm : ∀ v : D, U (T v) = T' ⟨U (v : F), hU v⟩) (z : ℂ)
    (hT : DeficiencyTrivialAt D T z) : DeficiencyTrivialAt D T' z := by

  intro w hw
  have hw' : ∀ v : D, (inner ℂ (T v) (U.symm w) : ℂ) = z * inner ℂ (v : F) (U.symm w) := by
    intro v
    have h1 : (inner ℂ (T v) (U.symm w) : ℂ) = inner ℂ (U (T v)) w := by
      rw [← U.inner_map_map (T v) (U.symm w), U.apply_symm_apply]
    have h2 : (inner ℂ ((v : F)) (U.symm w) : ℂ) = inner ℂ (U (v : F)) w := by
      rw [← U.inner_map_map (v : F) (U.symm w), U.apply_symm_apply]
    rw [h1, h2, hcomm v]
    exact hw ⟨U (v : F), hU v⟩
  have hzero : U.symm w = 0 := hT _ hw'
  have := congrArg U hzero
  rwa [U.apply_symm_apply, map_zero] at this
