-- Generated from ChapterA4g.lean — solution of BookProof.ChapterA4g.rotGenZ_coeffMass1Z_comm
import Mathlib
import Definitions.Def_ChapterA4g
open BookProof.ChapterA4g



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (i j : Fin 3) :
    rotGenZ i j * coeffMass1Z = coeffMass1Z * rotGenZ i j := by

  fin_cases i <;> fin_cases j <;> decide
