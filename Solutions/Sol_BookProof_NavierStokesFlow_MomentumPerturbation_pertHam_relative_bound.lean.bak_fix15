-- Generated from ChapterNavierStokesMomentumPerturbation.lean — solution of BookProof.NavierStokesFlow.MomentumPerturbation.pertHam_relative_bound
import Mathlib
import Definitions.Def_ChapterNavierStokesMomentumPerturbation
import Theorems.Thm_BookProof_NavierStokesFlow_MomentumPerturbation_rankTwo_norm_le
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.MomentumPerturbation





open LpNat BookProof.FarisLavine IkebeKato

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (c : ι → ℝ) (u w : L2I ι) (x : maxDom c) :
    ‖pertHam c u w x‖ ^ 2
      ≤ 2 * ‖diagMax c x‖ ^ 2 + (2 * (2 * (‖u‖ * ‖w‖)) ^ 2) * ‖(x : L2I ι)‖ ^ 2 := by

  have htri : ‖pertHam c u w x‖ ≤ ‖diagMax c x‖ + ‖rankTwo u w (x : L2I ι)‖ := by
    rw [pertHam_apply]
    exact norm_add_le _ _
  have hB := rankTwo_norm_le u w ((x : L2I ι))
  have hM : (0 : ℝ) ≤ 2 * (‖u‖ * ‖w‖) := by positivity
  nlinarith [norm_nonneg (pertHam c u w x), norm_nonneg (diagMax c x),
    norm_nonneg (rankTwo u w ((x : L2I ι))), norm_nonneg ((x : L2I ι)),
    sq_nonneg (‖diagMax c x‖ - ‖rankTwo u w ((x : L2I ι))‖),
    mul_nonneg hM (norm_nonneg ((x : L2I ι)))]
