-- Generated from ChapterNavierStokesMomentumPerturbation.lean — solution of BookProof.NavierStokesFlow.MomentumPerturbation.rankTwo_norm_le
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation





open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (u w x : L2I ι) : ‖rankTwo u w x‖ ≤ 2 * (‖u‖ * ‖w‖) * ‖x‖ := by

  refine le_trans (norm_add_le _ _) ?_
  rw [norm_smul, norm_smul]
  have h1 : ‖(inner ℂ u x : ℂ)‖ ≤ ‖u‖ * ‖x‖ := norm_inner_le_norm u x
  have h2 : ‖(inner ℂ w x : ℂ)‖ ≤ ‖w‖ * ‖x‖ := norm_inner_le_norm w x
  nlinarith [norm_nonneg u, norm_nonneg w, norm_nonneg x,
    mul_nonneg (norm_nonneg u) (norm_nonneg x), mul_nonneg (norm_nonneg w) (norm_nonneg x)]
