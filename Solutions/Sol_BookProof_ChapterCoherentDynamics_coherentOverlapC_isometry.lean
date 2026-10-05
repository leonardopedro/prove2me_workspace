-- Generated from ChapterCoherentDynamics.lean — solution of BookProof.ChapterCoherentDynamics.coherentOverlapC_isometry
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
open BookProof.ChapterCoherentDynamics



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution
    (U : EuclideanSpace ℂ (Fin n) ≃ₗᵢ[ℂ] EuclideanSpace ℂ (Fin n))
    (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC (U q) (U k) = coherentOverlapC q k := by

  rw [coherentOverlapC, coherentOverlapC, U.norm_map, U.norm_map, U.inner_map_map]
