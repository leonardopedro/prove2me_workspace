-- Generated from ChapterA4g.lean — solution of BookProof.ChapterA4g.rotGen_enSign_comm
import Mathlib
import Definitions.Def_ChapterA4g
import Theorems.Thm_BookProof_ChapterA4g_rotGenZ_coeffMass1Z_comm
open BookProof.ChapterA4g



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) :
    rotGen i j * enSign = enSign * rotGen i j := by

  rw [rotGen, enSign, ← map_mul, ← map_mul, rotGenZ_coeffMass1Z_comm]
