-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.flipU_mem_maxDom
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_IkebeKato_memLpTwo_of_le
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (p : ι → ℕ) (s : ι → ℝ) {x : L2I ι} (hx : x ∈ maxDom s) :
    flipU p x ∈ maxDom s := by

  refine memLpTwo_of_le (⟨fun k => (s k : ℂ) * (x : ι → ℂ) k, hx⟩ : L2I ι) fun k => ?_
  simp [flipU_coe]
