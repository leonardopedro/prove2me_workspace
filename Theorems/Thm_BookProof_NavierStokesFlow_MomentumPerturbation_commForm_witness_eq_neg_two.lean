-- Generated from ChapterNavierStokesMomentumPerturbation.lean — theorem BookProof.NavierStokesFlow.MomentumPerturbation.commForm_witness_eq_neg_two
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesFockManyMode
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumPerturbation_testState_mem_maxDom
open BookProof.NavierStokesFlow.FockManyMode
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation




open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}


theorem BookProof.NavierStokesFlow.MomentumPerturbation.commForm_witness_eq_neg_two :
    commForm (pertHam linSymbol (eState 0) (eState 1)) (diagMax linSymbol)
      ⟨testState, testState_mem_maxDom⟩ = -2 := by sorry
