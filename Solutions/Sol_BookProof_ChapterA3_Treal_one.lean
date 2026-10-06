-- Generated from ChapterA3i.lean — solution of BookProof.ChapterA3.Treal_one
import Mathlib
import Definitions.Def_ChapterA3i
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution : Treal (1 : Matrix (Fin 2) (Fin 2) ℂ) = 1 := by

  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Treal]
