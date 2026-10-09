-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.flipU_mem_finiteModes
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_mem_lpFiniteModes
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (p : ι → ℕ) {x : L2I ι} (hx : x ∈ lpFiniteModes ι) :
    flipU p x ∈ lpFiniteModes ι := by

  refine mem_lpFiniteModes.mpr (Set.Finite.subset (mem_lpFiniteModes.mp hx) fun β hβ => ?_)
  simp only [Function.mem_support, flipU_coe, ne_eq, mul_eq_zero, not_or] at hβ
  exact hβ.2
