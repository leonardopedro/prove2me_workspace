-- Generated from ChapterCoherentDynamics.lean — solution of BookProof.ChapterCoherentDynamics.bornNumerC_isometry
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
import Theorems.Thm_BookProof_ChapterCoherentDynamics_coherentOverlapC_isometry
open BookProof.ChapterCoherentDynamics



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (U : EuclideanSpace ℂ (Fin n) ≃ₗᵢ[ℂ] EuclideanSpace ℂ (Fin n))
    (q k : EuclideanSpace ℂ (Fin n)) : bornNumerC (U q) (U k) = bornNumerC q k := by

  rw [bornNumerC, bornNumerC, coherentOverlapC_isometry]
