-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.isPin_one
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_hasLambda_one
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : IsPin (1 : Matrix (Fin 4) (Fin 4) ℝ) := by

  refine ⟨by simp, by simp, ⟨1, hasLambda_one⟩⟩
