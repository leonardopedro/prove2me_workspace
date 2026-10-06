-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.mul_vecMulVec
import Definitions.Def_ChapterGravityProjector
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
open BookProof.ChapterGravityPolymomentum



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityPolymomentum.mul_vecMulVec (M : Matrix (Fin 4) (Fin 4) ℝ) (w u : Fin 4 → ℝ) :
    M * vecMulVec w u = vecMulVec (M.mulVec w) u := by sorry
