-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.mul_spatialProj_transpose
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityPolymomentum



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityPolymomentum.mul_spatialProj_transpose (v : Fin 4 → ℝ) (M : Matrix (Fin 4) (Fin 4) ℝ) :
    M * (spatialProj v)ᵀ = M + vecMulVec (M.mulVec (lower v)) v := by sorry
