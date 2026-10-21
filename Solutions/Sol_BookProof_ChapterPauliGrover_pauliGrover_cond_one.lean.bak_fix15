-- Generated from ChapterPauliGrover.lean — solution of BookProof.ChapterPauliGrover.pauliGrover_cond_one
import Mathlib
import Definitions.Def_ChapterPauliGrover
import Theorems.Thm_BookProof_ChapterPauliGrover_pauliGrover_joint_one
import Theorems.Thm_BookProof_ChapterPauliGrover_pauliGrover_marg_one
open BookProof.ChapterPauliGrover



open scoped BigOperators Matrix ComplexConjugate
open Matrix
open BookProof.ChapterConditional

set_option maxHeartbeats 1000000 in
theorem solution : pCond pauliX (0 : Fin 2) 1 = 1 := by

  rw [pCond, pauliGrover_joint_one, pauliGrover_marg_one]
  norm_num
