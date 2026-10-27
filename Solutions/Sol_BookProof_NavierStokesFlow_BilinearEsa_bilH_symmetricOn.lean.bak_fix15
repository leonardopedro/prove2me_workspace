-- Generated from ChapterNavierStokesBilinearEsa.lean — solution of BookProof.NavierStokesFlow.BilinearEsa.bilH_symmetricOn
import Mathlib
import Definitions.Def_ChapterNavierStokesBilinearEsa
import Theorems.Thm_BookProof_NavierStokesFlow_BilinearEsa_hasSum_inner_blocks
import Theorems.Thm_BookProof_NavierStokesFlow_BilinearEsa_blockVec_mem_maxDom
import Theorems.Thm_BookProof_NavierStokesFlow_BilinearEsa_blockVec_bilH
import Theorems.Thm_BookProof_NavierStokesFlow_HermiteFarisLavine_nsH_symmetricOn
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.BilinearEsa



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) :
    SymmetricOn (lpFiniteModes (ℕ × J)) (bilH κ) := by

  intro x y
  have h1 := hasSum_inner_blocks ((bilH κ x : L2I (ℕ × J))) ((y : L2I (ℕ × J)))
  have h2 := hasSum_inner_blocks ((x : L2I (ℕ × J))) ((bilH κ y : L2I (ℕ × J)))
  have heq : ∀ j : J,
      (inner ℂ (blockVec ((bilH κ x : L2I (ℕ × J))) j) (blockVec ((y : L2I (ℕ × J))) j) : ℂ)
        = inner ℂ (blockVec ((x : L2I (ℕ × J))) j)
            (blockVec ((bilH κ y : L2I (ℕ × J))) j) := by
    intro j
    rw [blockVec_bilH κ hκ x j, blockVec_bilH κ hκ y j]
    exact nsH_symmetricOn (hκ j) ⟨_, blockVec_mem_maxDom κ x j⟩ ⟨_, blockVec_mem_maxDom κ y j⟩
  simp only [heq] at h1
  exact h1.unique h2
