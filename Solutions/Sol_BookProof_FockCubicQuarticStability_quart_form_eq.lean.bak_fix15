-- Generated from ChapterFockCubicQuarticStability.lean — solution of BookProof.FockCubicQuarticStability.quart_form_eq
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
    (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re = ‖toLp (annA k (annA k u))‖ ^ 2 := by

  have hq : quartA k u = creA k (creA k (annA k (annA k u))) := rfl
  have h : (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ)
      = inner ℂ (toLp (annA k (annA k u))) (toLp (annA k (annA k u))) := by
    rw [hq, inner_creA_right, inner_creA_right]
  rw [h, inner_self_eq_norm_sq_to_K]
  simp [← Complex.ofReal_pow]
