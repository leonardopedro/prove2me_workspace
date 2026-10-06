-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.spatialProj_transpose
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) :
    (spatialProj v)ᵀ = 1 + vecMulVec (lower v) v := by

  ext a b
  simp [spatialProj, vecMulVec_apply, Matrix.transpose_apply, Matrix.one_apply, eq_comm, mul_comm]
