-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.proj_add
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (M N : Matrix (Fin 4) (Fin 4) ℝ) :
    proj v (M + N) = proj v M + proj v N := by

  simp [proj, Matrix.mul_add, Matrix.add_mul]
