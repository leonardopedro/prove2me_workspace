-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.proj_eq_self_of_spatial
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_spatialProj_mul
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_mul_spatialProj_transpose
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) {M : Matrix (Fin 4) (Fin 4) ℝ}
    (h : IsSpatial v M) : proj v M = M := by

  rw [proj, spatialProj_mul, h.left]
  simp [mul_spatialProj_transpose, h.right]
