-- Generated from ChapterAbelianDiagonalCountable.lean — solution of BookProof.ChapterAbelianDiagonalCountable.diagOp_smul
import Mathlib
import Definitions.Def_ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianDiagonalCountable



open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (d : EllInf) : diagOp (c • d) = c • diagOp d := by

  ext f i
  simp [mul_assoc]
