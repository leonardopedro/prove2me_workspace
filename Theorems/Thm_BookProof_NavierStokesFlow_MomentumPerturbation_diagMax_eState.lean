-- Generated from ChapterNavierStokesMomentumPerturbation.lean — theorem BookProof.NavierStokesFlow.MomentumPerturbation.diagMax_eState
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumPerturbation_eState_mem_maxDom
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation




open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}


theorem BookProof.NavierStokesFlow.MomentumPerturbation.diagMax_eState (k : ℕ) :
    (diagMax linSymbol ⟨eState k, eState_mem_maxDom k⟩ : L2I ℕ)
      = ((linSymbol k : ℂ)) • eState k := by sorry
