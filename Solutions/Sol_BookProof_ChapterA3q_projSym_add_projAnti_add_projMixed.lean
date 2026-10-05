-- Generated from ChapterA3q.lean — solution of BookProof.ChapterA3q.projSym_add_projAnti_add_projMixed
import Mathlib
import Definitions.Def_ChapterA3q
open BookProof.ChapterA3q



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution (N : ℕ) :
    projSym N + projAnti N + projMixed N = 1 := by

  unfold projMixed; abel
