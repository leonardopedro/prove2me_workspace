-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.vecMulVec_self_transpose
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) :
    (vecMulVec v v)ᵀ = vecMulVec v v := by

  ext a b; simp [vecMulVec_apply, Matrix.transpose_apply, mul_comm]
