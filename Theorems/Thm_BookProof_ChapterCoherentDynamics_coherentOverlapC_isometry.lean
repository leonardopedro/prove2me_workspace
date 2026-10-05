-- Generated from ChapterCoherentDynamics.lean — theorem BookProof.ChapterCoherentDynamics.coherentOverlapC_isometry
import Definitions.Def_ChapterCoherentFidelity
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentDynamics

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity


theorem BookProof.ChapterCoherentDynamics.coherentOverlapC_isometry
    (U : EuclideanSpace ℂ (Fin n) ≃ₗᵢ[ℂ] EuclideanSpace ℂ (Fin n))
    (q k : EuclideanSpace ℂ (Fin n)) :
    coherentOverlapC (U q) (U k) = coherentOverlapC q k := by sorry
