-- Generated from ChapterCoherentOverlap.lean — solution of BookProof.ChapterCoherentOverlap.coherentOverlap_comm
import Mathlib
import Definitions.Def_ChapterCoherentOverlap
open BookProof.ChapterCoherentOverlap



open scoped BigOperators

noncomputable section


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℝ (Fin n)) :
    coherentOverlap q k = coherentOverlap k q := by

  rw [coherentOverlap, coherentOverlap, real_inner_comm]
  ring_nf
