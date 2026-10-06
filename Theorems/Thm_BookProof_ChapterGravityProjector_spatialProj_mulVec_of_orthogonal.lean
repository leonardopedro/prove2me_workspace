-- Generated from ChapterGravityProjector.lean — theorem BookProof.ChapterGravityProjector.spatialProj_mulVec_of_orthogonal
import Mathlib
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector



open Matrix
open scoped BigOperators

theorem BookProof.ChapterGravityProjector.spatialProj_mulVec_of_orthogonal (v x : Fin 4 → ℝ)
    (hx : ∑ a, lower v a * x a = 0) :
    (spatialProj v).mulVec x = x := by sorry
