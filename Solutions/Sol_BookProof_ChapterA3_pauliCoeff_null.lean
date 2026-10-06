-- Generated from ChapterA4d.lean — solution of BookProof.ChapterA3.pauliCoeff_null
import Mathlib
import Definitions.Def_ChapterA4d
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) :
    pauliCoeff (pauliσ 0 + pauliσ 3) μ =
      (if μ = 0 then 1 else 0) + (if μ = 3 then 1 else 0) := by

  fin_cases μ <;>
    simp [pauliCoeff, pauliσ, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two,
      Matrix.diag] <;> norm_num
