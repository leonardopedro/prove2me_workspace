-- Generated from ChapterA3h.lean — solution of BookProof.ChapterA3.pauliCoeff_comb
import Mathlib
import Definitions.Def_ChapterA3h
import Theorems.Thm_BookProof_ChapterA3_pauliσ_trace
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (c : Fin 4 → ℂ) (μ : Fin 4) :
    pauliCoeff (∑ ν, c ν • pauliσ ν) μ = c μ := by

  unfold pauliCoeff;
  simp [ Matrix.mul_sum, Matrix.trace_sum, pauliσ_trace ];
  ring
