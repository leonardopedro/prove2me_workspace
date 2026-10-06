-- Generated from ChapterAbelianDiagonalCountable.lean — solution of BookProof.ChapterAbelianDiagonalCountable.diagOp_star
import Mathlib
import Definitions.Def_ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianDiagonalCountable



open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (d : EllInf) (f g : Ell2C) :
    (inner ℂ (diagOp d f) g : ℂ) = inner ℂ f (diagOp (star d) g) := by

  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun i => ?_
  simp [RCLike.inner_apply, map_mul, mul_comm, mul_left_comm]
