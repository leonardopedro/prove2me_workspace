-- Generated from ChapterA3r.lean — solution of BookProof.ChapterA3r.trace_projMixed_two
import Mathlib
import Definitions.Def_ChapterA3r
import Theorems.Thm_BookProof_ChapterA3q_projMixed_two_eq_zero
open BookProof.ChapterA3r



open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q

set_option maxHeartbeats 1000000 in
theorem solution : Matrix.trace (projMixed 2) = 0 := by

  rw [projMixed_two_eq_zero, Matrix.trace_zero]
