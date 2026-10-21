-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.esgn_mul_shear
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (c : ℝ) (n : ℕ) :
    esgn c * ((shear |c| n : ℝ) : ℂ) = ((shear c n : ℝ) : ℂ) := by

  rcases lt_or_ge c 0 with h | h
  · rw [esgn_of_neg h, abs_of_neg h]
    simp only [shear]
    push_cast
    ring
  · rw [esgn_of_nonneg h, abs_of_nonneg h, one_mul]
