-- Generated from ChapterA3p.lean — solution of BookProof.ChapterA3p.tensorSquare_complete_reducibility
import Mathlib
import Definitions.Def_ChapterA3p
import Theorems.Thm_BookProof_ChapterA3p_projSym_mul_projAnti
import Theorems.Thm_BookProof_ChapterA3p_projAnti_mul_projSym
import Theorems.Thm_BookProof_ChapterA3p_projSym_add_projAnti_two
open BookProof.ChapterA3p



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o

set_option maxHeartbeats 1000000 in
theorem solution :
    projSym 2 + projAnti 2 = 1 ∧
    projSym 2 * projAnti 2 = 0 ∧
    projAnti 2 * projSym 2 = 0 ∧
    projSym 2 * projSym 2 = projSym 2 ∧
    projAnti 2 * projAnti 2 = projAnti 2 :=
  ⟨projSym_add_projAnti_two, projSym_mul_projAnti (by norm_num),
     projAnti_mul_projSym (by norm_num), projSym_idem, projAnti_idem⟩
