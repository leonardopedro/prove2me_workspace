-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.proj_transpose
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (M : Matrix (Fin 4) (Fin 4) ℝ) :
    proj v (Mᵀ) = (proj v M)ᵀ := by

  simp [proj, Matrix.transpose_mul, Matrix.mul_assoc]
