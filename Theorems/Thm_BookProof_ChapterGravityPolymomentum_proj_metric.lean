-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.proj_metric
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

theorem BookProof.ChapterGravityPolymomentum.proj_metric (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    proj v metric = metric + vecMulVec v v := by sorry
