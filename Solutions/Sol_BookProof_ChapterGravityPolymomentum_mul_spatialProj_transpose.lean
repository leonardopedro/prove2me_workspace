-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.mul_spatialProj_transpose
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_mul_vecMulVec
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_spatialProj_transpose
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (M : Matrix (Fin 4) (Fin 4) ℝ) :
    M * (spatialProj v)ᵀ = M + vecMulVec (M.mulVec (lower v)) v := by

  rw [spatialProj_transpose, Matrix.mul_add, Matrix.mul_one, mul_vecMulVec]
