-- Generated from ChapterA4c.lean — solution of BookProof.ChapterA3.pauliCoeff_one
import Mathlib
import Definitions.Def_ChapterA4c
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) :
    pauliCoeff (1 : Matrix (Fin 2) (Fin 2) ℂ) μ = if μ = 0 then 1 else 0 := by

  fin_cases μ <;>
    simp [pauliCoeff, pauliσ, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two, Matrix.diag]
  norm_num
