-- Generated from ChapterA4g.lean — solution of BookProof.ChapterA4g.rotGen_projPos_comm
import Mathlib
import Definitions.Def_ChapterA4g
import Theorems.Thm_BookProof_ChapterA4g_rotGen_enSign_comm
open BookProof.ChapterA4g



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) :
    rotGen i j * projPos = projPos * rotGen i j := by

  unfold projPos
  simp [mul_sub, sub_mul, mul_one, one_mul, rotGen_enSign_comm]
