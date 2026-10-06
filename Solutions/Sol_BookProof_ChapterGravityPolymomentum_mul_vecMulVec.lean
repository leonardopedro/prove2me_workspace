-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.mul_vecMulVec
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin 4) (Fin 4) ℝ) (w u : Fin 4 → ℝ) :
    M * vecMulVec w u = vecMulVec (M.mulVec w) u := by

  ext a b
  simp [Matrix.mul_apply, vecMulVec_apply, Matrix.mulVec, dotProduct, Finset.sum_mul, mul_assoc]
