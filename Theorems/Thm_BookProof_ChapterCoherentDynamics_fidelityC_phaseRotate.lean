-- Generated from ChapterCoherentDynamics.lean — theorem BookProof.ChapterCoherentDynamics.fidelityC_phaseRotate
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
import Definitions.Def_ChapterCoherentOverlapComplex
import Definitions.Def_ChapterA4
open BookProof.ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentDynamics

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity


theorem BookProof.ChapterCoherentDynamics.fidelityC_phaseRotate (theta : ℝ) (q k : EuclideanSpace ℂ (Fin n)) :
    fidelityC (phaseRotate theta q) (phaseRotate theta k) = fidelityC q k := by sorry
