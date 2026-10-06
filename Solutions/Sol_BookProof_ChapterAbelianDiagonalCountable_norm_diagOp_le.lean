-- Generated from ChapterAbelianDiagonalCountable.lean — solution of BookProof.ChapterAbelianDiagonalCountable.norm_diagOp_le
import Mathlib
import Definitions.Def_ChapterAbelianDiagonalCountable
open BookProof.ChapterAbelianDiagonalCountable



open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (d : EllInf) : ‖diagOp d‖ ≤ ‖d‖ := LinearMap.mkContinuous_norm_le _ (norm_nonneg _) _
