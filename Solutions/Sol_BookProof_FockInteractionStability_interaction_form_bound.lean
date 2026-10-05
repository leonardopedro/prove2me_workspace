-- Generated from ChapterFockInteractionStability.lean — solution of BookProof.FockInteractionStability.interaction_form_bound
import Mathlib
import Definitions.Def_ChapterFockInteractionStability
open BookProof.FockInteractionStability



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap
open BookProof.FarisLavine BookProof.NavierStokesFlow



variable {E : Type*} [NormedAddCommGroup E]

variable {E : Type*} [NormedAddCommGroup E]

set_option maxHeartbeats 1000000 in
theorem solution [InnerProductSpace ℂ E] (V : E →L[ℂ] E) (x : E) :
    |(inner ℂ x (V x) : ℂ).re| ≤ ‖V‖ * ‖x‖ ^ 2 := by

  calc |(inner ℂ x (V x) : ℂ).re| ≤ ‖(inner ℂ x (V x) : ℂ)‖ := Complex.abs_re_le_norm _
    _ ≤ ‖x‖ * ‖V x‖ := norm_inner_le_norm _ _
    _ ≤ ‖x‖ * (‖V‖ * ‖x‖) := by
        exact mul_le_mul_of_nonneg_left (V.le_opNorm x) (norm_nonneg x)
    _ = ‖V‖ * ‖x‖ ^ 2 := by ring
