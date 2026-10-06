-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.spatialProj_mul
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityPolymomentum



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityPolymomentum.spatialProj_mul (v : Fin 4 → ℝ) (M : Matrix (Fin 4) (Fin 4) ℝ) :
    spatialProj v * M = M + vecMulVec v (M.vecMul (lower v)) := by sorry
