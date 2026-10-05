-- Generated from ChapterFockCubicQuarticStability.lean — solution of BookProof.FockCubicQuarticStability.quart_form_nonneg
import Mathlib
import Definitions.Def_ChapterFockCubicQuarticStability
import Theorems.Thm_BookProof_FockCubicQuarticStability_quart_form_eq
open BookProof.FockCubicQuarticStability



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicUnbounded

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (u : FockAlg) :
    0 ≤ (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re := by

  rw [quart_form_eq]; positivity
