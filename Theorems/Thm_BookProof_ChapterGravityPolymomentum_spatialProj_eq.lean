-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.spatialProj_eq
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityPolymomentum



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityPolymomentum.spatialProj_eq (v : Fin 4 → ℝ) : spatialProj v = 1 + vecMulVec v (lower v) := by sorry
