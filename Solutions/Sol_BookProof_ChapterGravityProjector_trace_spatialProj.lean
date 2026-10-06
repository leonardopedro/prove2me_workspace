-- Generated from ChapterGravityProjector.lean — solution of BookProof.ChapterGravityProjector.trace_spatialProj
import Mathlib
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector




open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialProj v).trace = 3 := by

  unfold spatialProj; norm_num [ minkSq, Matrix.mulVec, Matrix.trace ] at *;
  norm_num [ Finset.sum_add_distrib, hv ]
