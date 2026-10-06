-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.vecMulVec_mul
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (w u : Fin 4 → ℝ) (M : Matrix (Fin 4) (Fin 4) ℝ) :
    vecMulVec w u * M = vecMulVec w (M.vecMul u) := by

  ext a b
  simp [Matrix.mul_apply, vecMulVec_apply, Matrix.vecMul, dotProduct, Finset.mul_sum, mul_assoc]
