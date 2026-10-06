-- Generated from ChapterGravityTimeProj.lean — solution of BookProof.ChapterGravityTimeProj.trace_timeProj
import Mathlib
import Definitions.Def_ChapterGravityTimeProj
open BookProof.ChapterGravityTimeProj




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (timeProj v).trace = 1 := by

  unfold timeProj; simp only [trace, diag_apply, of_apply, Finset.sum_neg_distrib] ; ring;
  linarith!
