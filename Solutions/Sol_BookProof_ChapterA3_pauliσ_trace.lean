-- Generated from ChapterA3h.lean — solution of BookProof.ChapterA3.pauliσ_trace
import Mathlib
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (μ ν : Fin 4) :
    (pauliσ μ * pauliσ ν).trace = if μ = ν then 2 else 0 := by

  fin_cases μ <;> fin_cases ν <;>
    simp [pauliσ, Matrix.trace, Matrix.mul_apply, Fin.sum_univ_two, Matrix.diag] <;> ring_nf
