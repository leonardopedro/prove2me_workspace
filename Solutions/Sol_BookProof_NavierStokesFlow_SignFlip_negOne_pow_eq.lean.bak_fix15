-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.negOne_pow_eq
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) : (-1 : ℂ) ^ k = 1 ∨ (-1 : ℂ) ^ k = -1 := by

  rcases Nat.even_or_odd k with hk | hk
  · exact Or.inl hk.neg_one_pow
  · exact Or.inr hk.neg_one_pow
