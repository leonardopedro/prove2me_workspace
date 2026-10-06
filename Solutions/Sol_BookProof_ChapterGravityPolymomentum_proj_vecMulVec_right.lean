-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.proj_vecMulVec_right
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_vecMulVec_mul
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_mul_vecMulVec
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (hv : minkSq v = -1) (u : Fin 4 → ℝ) :
    proj v (vecMulVec u v) = 0 := by

  have hXv : (spatialProj v).mulVec v = 0 := spatialProj_mulVec_self v hv
  have h1 : (spatialProj v)ᵀ.vecMul v = 0 := by
    rw [Matrix.vecMul_transpose, hXv]
  rw [proj, mul_vecMulVec, vecMulVec_mul, h1]
  simp
