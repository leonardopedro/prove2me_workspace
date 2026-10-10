-- Generated from ChapterA3h.lean — solution of BookProof.ChapterA3.paulisigma_herm
import Mathlib
import Definitions.Def_ChapterA3h
import Definitions.Def_ChapterA3
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

theorem solution (μ : Fin 4) : (pauliσ μ)ᴴ = pauliσ μ := by
  fin_cases μ <;>
    (ext i j; fin_cases i <;> fin_cases j <;>
      simp [pauliσ, Matrix.conjTranspose_apply])
