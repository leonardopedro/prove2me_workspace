-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.spatialProj_mul
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_vecMulVec_mul
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_spatialProj_eq
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (M : Matrix (Fin 4) (Fin 4) ℝ) :
    spatialProj v * M = M + vecMulVec v (M.vecMul (lower v)) := by

  rw [spatialProj_eq, Matrix.add_mul, Matrix.one_mul, vecMulVec_mul]
