-- Generated from ChapterCoherentDynamics.lean — theorem BookProof.ChapterCoherentDynamics.norm_phaseRotate
import Definitions.Def_ChapterCoherentOverlapComplex
import Definitions.Def_ChapterCoherentFidelity
import Mathlib
import Definitions.Def_ChapterCoherentDynamics
open BookProof.ChapterCoherentDynamics

variable {n m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex BookProof.ChapterCoherentFidelity


theorem BookProof.ChapterCoherentDynamics.norm_phaseRotate (theta : ℝ) (q : EuclideanSpace ℂ (Fin n)) :
    ‖phaseRotate theta q‖ = ‖q‖ := by sorry
