-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.trace_vecMulVec
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (w u : Fin 4 → ℝ) :
    (vecMulVec w u).trace = ∑ a, w a * u a := by

  simp [Matrix.trace, vecMulVec_apply]
