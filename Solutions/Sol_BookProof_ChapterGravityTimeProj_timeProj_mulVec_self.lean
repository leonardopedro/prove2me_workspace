-- Generated from ChapterGravityTimeProj.lean — solution of BookProof.ChapterGravityTimeProj.timeProj_mulVec_self
import Mathlib
import Definitions.Def_ChapterGravityTimeProj
open BookProof.ChapterGravityTimeProj




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (timeProj v).mulVec v = v := by

  ext a;
  simp [minkSq, timeProj] at hv ⊢;
  simp_all [ Matrix.mulVec, dotProduct, Fin.sum_univ_four ];
  linear_combination -hv * v a
