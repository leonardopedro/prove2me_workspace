-- Generated from ChapterGravityIrrep.lean — solution of BookProof.ChapterGravityIrrep.symTracelessPart_symm
import Mathlib
import Definitions.Def_ChapterGravityIrrep
open BookProof.ChapterGravityIrrep




open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin 3) (Fin 3) ℝ) :
    (symTracelessPart M)ᵀ = symTracelessPart M := by

  simp [symTracelessPart, transpose_sub, transpose_add, transpose_transpose, transpose_smul,
    Matrix.transpose_one]
  abel
