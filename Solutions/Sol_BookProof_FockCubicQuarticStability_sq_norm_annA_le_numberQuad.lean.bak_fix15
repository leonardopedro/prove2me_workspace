-- Generated from ChapterFockCubicQuarticStability.lean — solution of BookProof.FockCubicQuarticStability.sq_norm_annA_le_numberQuad
import Mathlib
import Definitions.Def_ChapterFockCubicQuarticStability
import Theorems.Thm_BookProof_FockFieldPerturbation_sum_sq_annA_le
open BookProof.FockCubicQuarticStability



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicUnbounded

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (u : FockAlg) :
    ‖toLp (annA k u)‖ ^ 2 ≤ numberQuad u := by

  have h := sum_sq_annA_le u {k}
  rwa [Finset.sum_singleton] at h
