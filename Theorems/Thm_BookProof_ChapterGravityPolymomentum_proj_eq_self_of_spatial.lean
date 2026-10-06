-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.proj_eq_self_of_spatial
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Definitions.Def_ChapterElectroweakFieldStrength
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterElectroweakFieldStrength
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityPolymomentum



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityPolymomentum.proj_eq_self_of_spatial (v : Fin 4 → ℝ) {M : Matrix (Fin 4) (Fin 4) ℝ}
    (h : IsSpatial v M) : proj v M = M := by sorry
