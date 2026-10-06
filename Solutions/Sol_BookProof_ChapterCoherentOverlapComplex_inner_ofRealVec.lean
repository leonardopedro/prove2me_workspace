-- Generated from ChapterCoherentOverlapComplex.lean — solution of BookProof.ChapterCoherentOverlapComplex.inner_ofRealVec
import Mathlib
import Definitions.Def_ChapterCoherentOverlapComplex
open BookProof.ChapterCoherentOverlapComplex



open scoped BigOperators

noncomputable section


variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (q k : EuclideanSpace ℝ (Fin n)) :
    inner ℂ (ofRealVec q) (ofRealVec k) = ((inner ℝ q k : ℝ) : ℂ) := by

  rw [PiLp.inner_apply, PiLp.inner_apply]
  push_cast
  refine Finset.sum_congr rfl fun i _ => ?_
  simp [RCLike.inner_apply, ofRealVec, mul_comm]
