-- Generated from ChapterCoherentDynamics.lean — theorem BookProof.ChapterCoherentDynamics.bornNumerC_isometry
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


theorem BookProof.ChapterCoherentDynamics.bornNumerC_isometry (U : EuclideanSpace ℂ (Fin n) ≃ₗᵢ[ℂ] EuclideanSpace ℂ (Fin n))
    (q k : EuclideanSpace ℂ (Fin n)) : bornNumerC (U q) (U k) = bornNumerC q k := by sorry
