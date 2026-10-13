-- Generated from ChapterNavierStokesAffineBlockEsa.lean — solution of BookProof.NavierStokesFlow.AffineBlock.blockVec_affBlockH
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineBlockEsa
import Theorems.Thm_BookProof_NavierStokesFlow_AffineBlock_blockVec_mem_maxDom_prime
import Theorems.Thm_BookProof_NavierStokesFlow_AffineFiber_PairShift_pairH_coe
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineBlock



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian AffineFiber BilinearEsa
open BookProof.NavierStokesFlow.AffineFiber.PairShift

variable {J : Type*}

variable {J : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (κ c : J → ℝ) (hκ : ∀ j, 0 ≤ κ j) (hc : ∀ j, 0 ≤ c j)
    (v : lpFiniteModes (ℕ × J)) (j : J) :
    blockVec ((affBlockH κ c hκ hc v : L2I (ℕ × J))) j
      = affH (hκ j) (hc j)
          ⟨blockVec ((v : L2I (ℕ × J))) j, blockVec_mem_maxDom_prime _ v j⟩ := by

  refine lp.ext (funext fun n => ?_)
  rw [show ((affH (hκ j) (hc j)
      ⟨blockVec ((v : L2I (ℕ × J))) j, blockVec_mem_maxDom_prime _ v j⟩ : L2I ℕ) : ℕ → ℂ) n
    = _ from PairShift.pairH_coe (affData (hκ j) (hc j)) _ n]
  rfl
