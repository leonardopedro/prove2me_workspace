-- Generated from ChapterCoherentDynamics.lean — theorem BookProof.ChapterCoherentDynamics.bornWeightC_isometry
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


theorem BookProof.ChapterCoherentDynamics.bornWeightC_isometry (U : EuclideanSpace ℂ (Fin n) ≃ₗᵢ[ℂ] EuclideanSpace ℂ (Fin n))
    (q : EuclideanSpace ℂ (Fin n)) (k : Fin m → EuclideanSpace ℂ (Fin n)) (j : Fin m) :
    bornWeightC (U q) (fun l => U (k l)) j = bornWeightC q k j := by sorry
