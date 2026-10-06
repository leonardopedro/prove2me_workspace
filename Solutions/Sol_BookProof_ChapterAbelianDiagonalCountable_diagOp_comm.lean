-- Generated from ChapterAbelianDiagonalCountable.lean — solution of BookProof.ChapterAbelianDiagonalCountable.diagOp_comm
import Mathlib
import Definitions.Def_ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianDiagonalCountable



open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (d e : EllInf) :
    (diagOp d).comp (diagOp e) = (diagOp e).comp (diagOp d) := by

  ext f i
  simp [mul_left_comm]
