-- Generated from ChapterNavierStokesMomentumPerturbation.lean — solution of BookProof.NavierStokesFlow.MomentumPerturbation.rankTwo_symmetric
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation





open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (u w x y : L2I ι) :
    (inner ℂ (rankTwo u w x) y : ℂ) = inner ℂ x (rankTwo u w y) := by

  simp only [rankTwo_apply, inner_add_left, inner_add_right, inner_smul_left, inner_smul_right]
  rw [inner_conj_symm, inner_conj_symm]
  ring
