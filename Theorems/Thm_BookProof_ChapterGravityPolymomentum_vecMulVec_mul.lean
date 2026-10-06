-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.vecMulVec_mul
import Definitions.Def_ChapterGravityProjector
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
open BookProof.ChapterGravityPolymomentum



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityPolymomentum.vecMulVec_mul (w u : Fin 4 → ℝ) (M : Matrix (Fin 4) (Fin 4) ℝ) :
    vecMulVec w u * M = vecMulVec w (M.vecMul u) := by sorry
