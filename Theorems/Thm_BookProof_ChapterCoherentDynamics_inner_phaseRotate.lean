-- Generated from ChapterCoherentDynamics.lean — theorem BookProof.ChapterCoherentDynamics.inner_phaseRotate
import Definitions.Def_ChapterCoherentOverlapComplex
import Definitions.Def_ChapterCoherentFidelity
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
open BookProof.ChapterCoherentDynamics


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity

variable {n m : ℕ}


theorem BookProof.ChapterCoherentDynamics.inner_phaseRotate (theta : ℝ) (q k : EuclideanSpace ℂ (Fin n)) :
    (inner ℂ (phaseRotate theta q) (phaseRotate theta k) : ℂ) = inner ℂ q k := by sorry
