-- Generated from ChapterGravityIrrep.lean — solution of BookProof.ChapterGravityIrrep.trace_symTracelessPart
import Mathlib
import Definitions.Def_ChapterGravityIrrep
open BookProof.ChapterGravityIrrep




open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin 3) (Fin 3) ℝ) :
    (symTracelessPart M).trace = 0 := by

  simp [symTracelessPart, Matrix.trace, Matrix.diag, Fin.sum_univ_three]
  ring
