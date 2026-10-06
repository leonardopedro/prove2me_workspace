-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.hasLambda_one
import Mathlib
import Definitions.Def_ChapterA3d
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : HasLambda (1 : Matrix (Fin 4) (Fin 4) ℝ) 1 := by

  intro μ
  simp [Matrix.one_apply]
