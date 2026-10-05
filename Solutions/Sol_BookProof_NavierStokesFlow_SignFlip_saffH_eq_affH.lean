-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.saffH_eq_affH
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {κ : ℝ} (hκ : 0 ≤ κ) {c : ℝ} (hc : 0 ≤ c) :
    saffH hκ c = affH hκ (abs_nonneg c) := by

  simp only [saffH, esgn_of_nonneg hc, one_smul]
  rfl
