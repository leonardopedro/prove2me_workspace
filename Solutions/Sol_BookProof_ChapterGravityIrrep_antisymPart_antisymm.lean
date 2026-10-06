-- Generated from ChapterGravityIrrep.lean — solution of BookProof.ChapterGravityIrrep.antisymPart_antisymm
import Mathlib
import Definitions.Def_ChapterGravityIrrep
open BookProof.ChapterGravityIrrep




open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin 3) (Fin 3) ℝ) :
    (antisymPart M)ᵀ = -(antisymPart M) := by

  simp [antisymPart, transpose_sub, transpose_transpose]
