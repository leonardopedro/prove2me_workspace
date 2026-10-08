-- Generated from ChapterNavierStokesMomentumPerturbation.lean — solution of BookProof.NavierStokesFlow.MomentumPerturbation.testState_mem_maxDom
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation





open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution : testState ∈ maxDom linSymbol :=
  finiteModes_le_maxDom linSymbol
      (Submodule.add_mem _ (lpSingle_mem_lpFiniteModes 0 (1 : ℂ))
        (lpSingle_mem_lpFiniteModes 1 Complex.I))
