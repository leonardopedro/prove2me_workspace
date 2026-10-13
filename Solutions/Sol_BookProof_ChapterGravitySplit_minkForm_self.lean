-- Generated from ChapterGravitySplit.lean — solution of BookProof.ChapterGravitySplit.minkForm_self
import Mathlib
import Definitions.Def_ChapterGravitySplit
import Definitions.Def_ChapterGravityTimeProj
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravitySplit




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

set_option maxHeartbeats 1000000 in
theorem solution (x : Fin 4 → ℝ) : minkForm x x = minkSq x := by

  rfl
