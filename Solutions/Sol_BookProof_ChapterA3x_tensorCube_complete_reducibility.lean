-- Generated from ChapterA3x.lean — solution of BookProof.ChapterA3x.tensorCube_complete_reducibility
import Mathlib
import Definitions.Def_ChapterA3x
import Theorems.Thm_BookProof_ChapterA3x_projSym_add_projAnti_add_projMixed
import Theorems.Thm_BookProof_ChapterA3x_projSym_mul_projMixed
import Theorems.Thm_BookProof_ChapterA3x_projMixed_mul_projSym
import Theorems.Thm_BookProof_ChapterA3x_projAnti_mul_projMixed
import Theorems.Thm_BookProof_ChapterA3x_projMixed_mul_projAnti
import Theorems.Thm_BookProof_ChapterA3x_projMixed_idem
import Theorems.Thm_BookProof_ChapterA3x_projMixed_three_ne_zero
import Theorems.Thm_BookProof_ChapterA3n_projSym_idem
import Theorems.Thm_BookProof_ChapterA3o_projAnti_idem
import Theorems.Thm_BookProof_ChapterA3p_projAnti_mul_projSym
import Theorems.Thm_BookProof_ChapterA3p_projSym_mul_projAnti
open BookProof.ChapterA3x



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution :
    projSym 3 + projAnti 3 + projMixed 3 = 1 ∧
    projSym 3 * projSym 3 = projSym 3 ∧
    projAnti 3 * projAnti 3 = projAnti 3 ∧
    projMixed 3 * projMixed 3 = projMixed 3 ∧
    projSym 3 * projAnti 3 = 0 ∧ projAnti 3 * projSym 3 = 0 ∧
    projSym 3 * projMixed 3 = 0 ∧ projMixed 3 * projSym 3 = 0 ∧
    projAnti 3 * projMixed 3 = 0 ∧ projMixed 3 * projAnti 3 = 0 ∧
    projMixed 3 ≠ 0 :=
  ⟨projSym_add_projAnti_add_projMixed 3, projSym_idem, projAnti_idem,
      projMixed_idem (by norm_num),
      projSym_mul_projAnti (by norm_num), projAnti_mul_projSym (by norm_num),
      projSym_mul_projMixed (by norm_num), projMixed_mul_projSym (by norm_num),
      projAnti_mul_projMixed (by norm_num), projMixed_mul_projAnti (by norm_num),
      projMixed_three_ne_zero⟩
