-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.proj_transpose
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (M : Matrix (Fin 4) (Fin 4) ℝ) :
    BookProof.ChapterGravityPolymomentum.proj v (Mᵀ) = (BookProof.ChapterGravityPolymomentum.proj v M)ᵀ := by

  simp [BookProof.ChapterGravityPolymomentum.proj, Matrix.transpose_mul, Matrix.mul_assoc]
