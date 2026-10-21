-- Generated from ChapterNavierStokesAffineBlockEsa.lean — solution of BookProof.NavierStokesFlow.AffineBlock.affBlockH_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineBlockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_AffineBlock_blockVec_mem_maxDom_prime
import Theorems.Thm_BookProof_NavierStokesFlow_AffineBlock_blockVec_affBlockH
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_affH_symmetricOn
import Theorems.Thm_BookProof_NavierStokesFlow_BilinearEsa_hasSum_inner_blocks
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineBlock



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber BilinearEsa

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (hc : ∀ j, 0 ≤ c j) :
    SymmetricOn (lpFiniteModes (ℕ × J)) (affBlockH κ c hκ hc) := by

  intro x y
  have h1 := hasSum_inner_blocks ((affBlockH κ c hκ hc x : L2I (ℕ × J))) ((y : L2I (ℕ × J)))
  have h2 := hasSum_inner_blocks ((x : L2I (ℕ × J))) ((affBlockH κ c hκ hc y : L2I (ℕ × J)))
  have heq : ∀ j : J,
      (inner ℂ (blockVec ((affBlockH κ c hκ hc x : L2I (ℕ × J))) j)
          (blockVec ((y : L2I (ℕ × J))) j) : ℂ)
        = inner ℂ (blockVec ((x : L2I (ℕ × J))) j)
            (blockVec ((affBlockH κ c hκ hc y : L2I (ℕ × J))) j) := by
    intro j
    rw [blockVec_affBlockH κ c hκ hc x j, blockVec_affBlockH κ c hκ hc y j]
    exact affH_symmetricOn (hκ j) (hc j) ⟨_, blockVec_mem_maxDom_prime _ x j⟩
      ⟨_, blockVec_mem_maxDom_prime _ y j⟩
  simp only [heq] at h1
  exact h1.unique h2
