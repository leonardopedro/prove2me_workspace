-- Generated from ChapterGravityPolymomentum.lean — theorem BookProof.ChapterGravityPolymomentum.trace_vecMulVec
import Definitions.Def_ChapterGravityProjector
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
open BookProof.ChapterGravityPolymomentum



open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

theorem BookProof.ChapterGravityPolymomentum.trace_vecMulVec (w u : Fin 4 → ℝ) :
    (vecMulVec w u).trace = ∑ a, w a * u a := by sorry
