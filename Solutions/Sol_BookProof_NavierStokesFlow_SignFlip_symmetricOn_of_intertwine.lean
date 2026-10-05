-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.symmetricOn_of_intertwine
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (U : F ≃ₗᵢ[ℂ] F) (T T' : D →ₗ[ℂ] F)
    (hU : ∀ v : D, U (v : F) ∈ D) (hUsurj : ∀ v : D, ∃ u : D, U (u : F) = (v : F))
    (hcomm : ∀ v : D, U (T v) = T' ⟨U (v : F), hU v⟩)
    (hT : SymmetricOn D T) : SymmetricOn D T' := by

  intro x y
  obtain ⟨a, ha⟩ := hUsurj x
  obtain ⟨b, hb⟩ := hUsurj y
  have hx : x = ⟨U (a : F), hU a⟩ := Subtype.ext ha.symm
  have hy : y = ⟨U (b : F), hU b⟩ := Subtype.ext hb.symm
  subst hx
  subst hy
  rw [← hcomm a, ← hcomm b]
  simpa [U.inner_map_map] using hT a b
