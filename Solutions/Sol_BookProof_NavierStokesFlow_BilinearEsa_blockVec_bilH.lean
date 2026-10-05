-- Generated from ChapterNavierStokesBilinearEsa.lean — solution of BookProof.NavierStokesFlow.BilinearEsa.blockVec_bilH
import Mathlib
import Definitions.Def_ChapterNavierStokesBilinearEsa
import Theorems.Thm_BookProof_NavierStokesFlow_BilinearEsa_blockVec_mem_maxDom
open BookProof.NavierStokesFlow



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (v : lpFiniteModes (ℕ × J)) (j : J) :
    blockVec ((bilH κ v : L2I (ℕ × J))) j
      = nsH (κ j) (hκ j) ⟨blockVec ((v : L2I (ℕ × J))) j, blockVec_mem_maxDom κ v j⟩ := lp.ext (funext fun _ => rfl)
