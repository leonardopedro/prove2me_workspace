-- Generated from ChapterA4e.lean — solution of BookProof.ChapterA4e.projPos_add_projNeg
import Mathlib
import Definitions.Def_ChapterA4e
open BookProof.ChapterA4e



open Matrix


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution : projPos + projNeg = 1 := by

  ext i j; simp [ projPos, projNeg ] ; ring
