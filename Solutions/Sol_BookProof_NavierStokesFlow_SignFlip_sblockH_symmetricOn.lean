-- Generated from ChapterNavierStokesSignFlip.lean — solution of BookProof.NavierStokesFlow.SignFlip.sblockH_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesSignFlip
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_saffH_symmetricOn
import Theorems.Thm_BookProof_NavierStokesFlow_SignFlip_blockVec_sblockH
import Theorems.Thm_BookProof_NavierStokesFlow_AffineBlock_blockVec_mem_maxDom'
import Theorems.Thm_BookProof_NavierStokesFlow_BilinearEsa_hasSum_inner_blocks
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.SignFlip



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {ι : Type*}
variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) :
    SymmetricOn (lpFiniteModes (ℕ × J)) (sblockH κ c hκ) := by

  intro x y
  have h1 := hasSum_inner_blocks ((sblockH κ c hκ x : L2I (ℕ × J))) ((y : L2I (ℕ × J)))
  have h2 := hasSum_inner_blocks ((x : L2I (ℕ × J))) ((sblockH κ c hκ y : L2I (ℕ × J)))
  have heq : ∀ j : J,
      (inner ℂ (blockVec ((sblockH κ c hκ x : L2I (ℕ × J))) j)
          (blockVec ((y : L2I (ℕ × J))) j) : ℂ)
        = inner ℂ (blockVec ((x : L2I (ℕ × J))) j)
            (blockVec ((sblockH κ c hκ y : L2I (ℕ × J))) j) := by
    intro j
    rw [blockVec_sblockH κ c hκ x j, blockVec_sblockH κ c hκ y j]
    exact saffH_symmetricOn (hκ j) (c j) ⟨_, AffineBlock.blockVec_mem_maxDom' _ x j⟩
      ⟨_, AffineBlock.blockVec_mem_maxDom' _ y j⟩
  simp only [heq] at h1
  exact h1.unique h2
