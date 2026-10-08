-- Generated from ChapterCoherentDynamics.lean — theorem BookProof.ChapterCoherentDynamics.bornNumerC_phaseRotate
import Definitions.Def_ChapterCoherentFidelity
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentDynamics


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity

variable {n m : ℕ}


theorem BookProof.ChapterCoherentDynamics.bornNumerC_phaseRotate (theta : ℝ) (q k : EuclideanSpace ℂ (Fin n)) :
    bornNumerC (phaseRotate theta q) (phaseRotate theta k) = bornNumerC q k := by sorry
