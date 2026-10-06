-- Generated from ChapterA3q.lean — solution of BookProof.ChapterA3q.tensorPow_complete_reducibility
import Mathlib
import Definitions.Def_ChapterA3q
import Theorems.Thm_BookProof_ChapterA3q_projSym_add_projAnti_add_projMixed
import Theorems.Thm_BookProof_ChapterA3q_projSym_mul_projMixed
import Theorems.Thm_BookProof_ChapterA3q_projMixed_mul_projSym
import Theorems.Thm_BookProof_ChapterA3q_projAnti_mul_projMixed
import Theorems.Thm_BookProof_ChapterA3q_projMixed_mul_projAnti
import Theorems.Thm_BookProof_ChapterA3q_projMixed_idem
import Theorems.Thm_BookProof_ChapterA3n_projSym_idem
import Theorems.Thm_BookProof_ChapterA3o_projAnti_idem
import Theorems.Thm_BookProof_ChapterA3p_projAnti_mul_projSym
import Theorems.Thm_BookProof_ChapterA3p_projSym_mul_projAnti
open BookProof.ChapterA3q



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (hN : 2 ≤ N) :
    projSym N + projAnti N + projMixed N = 1 ∧
    projSym N * projSym N = projSym N ∧
    projAnti N * projAnti N = projAnti N ∧
    projMixed N * projMixed N = projMixed N ∧
    projSym N * projAnti N = 0 ∧ projAnti N * projSym N = 0 ∧
    projSym N * projMixed N = 0 ∧ projMixed N * projSym N = 0 ∧
    projAnti N * projMixed N = 0 ∧ projMixed N * projAnti N = 0 :=
  ⟨projSym_add_projAnti_add_projMixed N, projSym_idem, projAnti_idem,
     projMixed_idem hN, projSym_mul_projAnti hN, projAnti_mul_projSym hN,
     projSym_mul_projMixed hN, projMixed_mul_projSym hN,
     projAnti_mul_projMixed hN, projMixed_mul_projAnti hN⟩
