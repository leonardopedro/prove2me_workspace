-- Generated from ChapterGravitySplit.lean — solution of BookProof.ChapterGravitySplit.minkForm_self
import Mathlib
import Definitions.Def_ChapterGravitySplit
open BookProof.ChapterGravitySplit




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

set_option maxHeartbeats 1000000 in
theorem solution (x : Fin 4 → ℝ) : minkForm x x = minkSq x := by

  rfl
