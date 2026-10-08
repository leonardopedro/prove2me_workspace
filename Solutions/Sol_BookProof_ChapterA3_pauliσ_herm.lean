-- Generated from ChapterA3h.lean — solution of BookProof.ChapterA3.paulisigma_herm
import Mathlib
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) : (pauliσ μ)ᴴ = pauliσ μ := by

  fin_cases μ <;>
    (ext i j; fin_cases i <;> fin_cases j <;>
      simp [pauliσ, Matrix.conjTranspose_apply])
