-- Generated from ChapterFockCubicQuarticStability.lean — solution of BookProof.FockCubicQuarticStability.sq_norm_annA_le_mul
import Mathlib
import Definitions.Def_ChapterFockCubicQuarticStability
import Theorems.Thm_BookProof_FockSecondQuantization_inner_creA_right
open BookProof.FockCubicQuarticStability



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicUnbounded

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (u : FockAlg) :
    ‖toLp (annA k u)‖ ^ 2 ≤ ‖toLp u‖ * ‖toLp (creA k (annA k u))‖ := by

  have h1 : (inner ℂ (toLp u) (toLp (creA k (annA k u))) : ℂ)
      = inner ℂ (toLp (annA k u)) (toLp (annA k u)) := by
    rw [inner_creA_right]
  have h2 : ‖(inner ℂ (toLp u) (toLp (creA k (annA k u))) : ℂ)‖
      ≤ ‖toLp u‖ * ‖toLp (creA k (annA k u))‖ := norm_inner_le_norm _ _
  rw [h1, inner_self_eq_norm_sq_to_K] at h2
  simpa [abs_of_nonneg (sq_nonneg ‖toLp (annA k u)‖)] using h2
