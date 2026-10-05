-- Generated from ChapterA3x.lean — solution of BookProof.ChapterA3x.projMixed_two_eq_zero
import Mathlib
import Definitions.Def_ChapterA3x
import Theorems.Thm_BookProof_ChapterA3p_projSym_add_projAnti_two
open BookProof.ChapterA3x



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution : projMixed 2 = 0 := by

  have h := BookProof.ChapterA3p.projSym_add_projAnti_two
  simp only [projMixed]
  rw [show (1 : MN 2) - projSym 2 - projAnti 2 = 1 - (projSym 2 + projAnti 2) by abel, h,
    sub_self]
