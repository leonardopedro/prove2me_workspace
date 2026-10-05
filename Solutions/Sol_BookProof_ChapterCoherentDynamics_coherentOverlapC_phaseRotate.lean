-- Generated from ChapterCoherentDynamics.lean — solution of BookProof.ChapterCoherentDynamics.coherentOverlapC_phaseRotate
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
import Theorems.Thm_BookProof_ChapterCoherentDynamics_norm_phaseRotate
import Theorems.Thm_BookProof_ChapterCoherentDynamics_inner_phaseRotate
open BookProof.ChapterCoherentDynamics



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (theta : ℝ) (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC (phaseRotate theta q) (phaseRotate theta k) = coherentOverlapC q k := by

  rw [coherentOverlapC, coherentOverlapC, norm_phaseRotate, norm_phaseRotate,
    inner_phaseRotate]
