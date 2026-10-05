-- Generated from ChapterA3h.lean — solution of BookProof.ChapterA3.toC_minkowski_symm
import Mathlib
import Definitions.Def_ChapterA3h
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution : (toC minkowskiMat)ᵀ = toC minkowskiMat := by

  ext i j; simp only [toC, transpose_apply, map_apply, Complex.ofReal_inj] ;
  fin_cases i <;> fin_cases j <;> rfl
