-- Generated from ChapterA4d.lean — solution of BookProof.ChapterA3.pauliCoeff_add
import Mathlib
import Definitions.Def_ChapterA4d
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (A B : Matrix (Fin 2) (Fin 2) ℂ) (μ : Fin 4) :
    pauliCoeff (A + B) μ = pauliCoeff A μ + pauliCoeff B μ := by

  simp [pauliCoeff, Matrix.trace_add, mul_add]
