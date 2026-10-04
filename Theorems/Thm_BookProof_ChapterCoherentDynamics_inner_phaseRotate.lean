-- Generated from ChapterCoherentDynamics.lean — theorem BookProof.ChapterCoherentDynamics.inner_phaseRotate
import Definitions.Def_ChapterCoherentOverlapComplex
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
import Definitions.Def_ChapterA4
open BookProof.ChapterCoherentDynamics

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity


theorem BookProof.ChapterCoherentDynamics.inner_phaseRotate (theta : ℝ) (q k : EuclideanSpace ℂ (Fin n)) :
    (inner ℂ (phaseRotate theta q) (phaseRotate theta k) : ℂ) = inner ℂ q k := by sorry
