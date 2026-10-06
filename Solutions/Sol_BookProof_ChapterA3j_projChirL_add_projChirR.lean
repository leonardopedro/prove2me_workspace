-- Generated from ChapterA3j.lean — solution of BookProof.ChapterA3j.projChirL_add_projChirR
import Mathlib
import Definitions.Def_ChapterA3j
open BookProof.ChapterA3j



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : projChirL + projChirR = 1 := by

  ext i j; simp [projChirL, projChirR]; ring
