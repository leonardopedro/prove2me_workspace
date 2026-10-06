-- Generated from ChapterCoherentOverlap.lean — solution of BookProof.ChapterCoherentOverlap.coherentOverlap_self
import Mathlib
import Definitions.Def_ChapterCoherentOverlap
import Theorems.Thm_BookProof_ChapterCoherentOverlap_coherentOverlap_eq_gaussian
open BookProof.ChapterCoherentOverlap



open scoped BigOperators

noncomputable section


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q q = 1 := by

  rw [coherentOverlap_eq_gaussian]
  simp
