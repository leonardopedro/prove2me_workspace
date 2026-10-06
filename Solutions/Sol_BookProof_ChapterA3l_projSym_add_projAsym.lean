-- Generated from ChapterA3l.lean — solution of BookProof.ChapterA3l.projSym_add_projAsym
import Mathlib
import Definitions.Def_ChapterA3l
open BookProof.ChapterA3l



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k

set_option maxHeartbeats 1000000 in
theorem solution : projSym + projAsym = 1 := by

  unfold projSym projAsym
  module
