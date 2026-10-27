-- Generated from ChapterNavierStokesMomentumPerturbation.lean — solution of BookProof.NavierStokesFlow.MomentumPerturbation.norm_eState
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation





open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) : ‖eState k‖ = 1 := by

  have h : ‖(eState k : L2I ℕ)‖ = ‖(1 : ℂ)‖ := lp.norm_single (by norm_num) k 1
  simpa using h
