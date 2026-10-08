-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.blockVec_sblockH
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_saffH_coe
import Theorems.Thm_BookProof_NavierStokesFlow_AffineBlock_blockVec_mem_maxDom_prime
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}
variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (v : lpFiniteModes (ℕ × J)) (j : J) :
    blockVec ((sblockH κ c hκ v : L2I (ℕ × J))) j
      = saffH (hκ j) (c j)
          ⟨blockVec ((v : L2I (ℕ × J))) j, AffineBlock.blockVec_mem_maxDom_prime _ v j⟩ := by

  refine lp.ext (funext fun n => ?_)
  rw [show ((saffH (hκ j) (c j)
      ⟨blockVec ((v : L2I (ℕ × J))) j, AffineBlock.blockVec_mem_maxDom_prime _ v j⟩ :
        L2I ℕ) : ℕ → ℂ) n = _ from saffH_coe (hκ j) (c j) _ n]
  rfl
