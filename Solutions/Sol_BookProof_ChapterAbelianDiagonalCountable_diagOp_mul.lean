-- Generated from ChapterAbelianDiagonalCountable.lean — solution of BookProof.ChapterAbelianDiagonalCountable.diagOp_mul
import Mathlib
import Definitions.Def_ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianDiagonalCountable



open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (d e : EllInf) : diagOp (d * e) = (diagOp d).comp (diagOp e) := by

  ext f i
  simp [mul_assoc]
