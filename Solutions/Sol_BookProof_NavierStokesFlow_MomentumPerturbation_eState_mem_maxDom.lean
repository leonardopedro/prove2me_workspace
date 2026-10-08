-- Generated from ChapterNavierStokesMomentumPerturbation.lean — solution of BookProof.NavierStokesFlow.MomentumPerturbation.eState_mem_maxDom
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation





open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) : eState k ∈ maxDom linSymbol := finiteModes_le_maxDom linSymbol (lpSingle_mem_lpFiniteModes k (1 : ℂ))
