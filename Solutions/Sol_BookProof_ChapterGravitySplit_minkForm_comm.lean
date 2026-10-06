-- Generated from ChapterGravitySplit.lean — solution of BookProof.ChapterGravitySplit.minkForm_comm
import Mathlib
import Definitions.Def_ChapterGravitySplit
open BookProof.ChapterGravitySplit




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

set_option maxHeartbeats 1000000 in
theorem solution (x y : Fin 4 → ℝ) : minkForm x y = minkForm y x := by

  unfold minkForm lower metric; norm_num [ Fin.sum_univ_four ] ; ring;
  simp [ *, Matrix.mulVec ] ; ring!;
