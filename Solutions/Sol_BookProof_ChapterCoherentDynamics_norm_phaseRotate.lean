-- Generated from ChapterCoherentDynamics.lean — solution of BookProof.ChapterCoherentDynamics.norm_phaseRotate
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
open BookProof.ChapterCoherentDynamics



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (theta : ℝ) (q : EuclideanSpace ℂ (Fin n)) :
    ‖phaseRotate theta q‖ = ‖q‖ := by

  rw [phaseRotate, norm_smul, Complex.norm_exp_ofReal_mul_I, one_mul]
