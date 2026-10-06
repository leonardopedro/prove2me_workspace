-- Generated from ChapterCoherentOverlap.lean — solution of BookProof.ChapterCoherentOverlap.coherentOverlap_unit
import Mathlib
import Definitions.Def_ChapterCoherentOverlap
import Theorems.Thm_BookProof_ChapterCoherentOverlap_coherentOverlap_self
open BookProof.ChapterCoherentOverlap



open scoped BigOperators

noncomputable section


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : EuclideanSpace ℝ (Fin n)) (_hq : ‖q‖ = 1) :
    coherentOverlap q q = 1 := coherentOverlap_self q
