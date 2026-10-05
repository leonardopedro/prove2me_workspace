-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.hFun_flip
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_negOne_pow_eq
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (S : ShiftData ι) (p : ι → ℕ) (k : ℕ)
    (hp : ∀ β, p (S.shift β) = p β + k) (X : ι → ℂ) (β : ι) :
    S.hFun (flipFun p X) β = (-1 : ℂ) ^ k * ((-1 : ℂ) ^ p β * S.hFun X β) := by

  rcases negOne_pow_eq k with hB | hB <;>
  · by_cases hb : ∃ α, S.shift α = β
    · obtain ⟨α, rfl⟩ := hb
      simp only [ShiftData.hFun, ShiftData.hop_shift, flipFun, hp α, hp (S.shift α),
        pow_add, hB]
      ring
    · have hz : ∀ g : ι → ℂ, S.hop g β = 0 := fun g => ShiftData.hop_eq_zero S g hb
      simp only [ShiftData.hFun, hz, flipFun, hp β, pow_add, hB]
      ring
