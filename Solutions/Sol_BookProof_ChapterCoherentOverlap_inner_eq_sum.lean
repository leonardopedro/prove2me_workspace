-- Generated from ChapterCoherentOverlap.lean — solution of BookProof.ChapterCoherentOverlap.inner_eq_sum
import Mathlib
import Definitions.Def_ChapterCoherentOverlap
open BookProof.ChapterCoherentOverlap



open scoped BigOperators

noncomputable section


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℝ (Fin n)) :
    inner ℝ q k = ∑ i, q i * k i := by

  rw [PiLp.inner_apply]
  simp [mul_comm]
