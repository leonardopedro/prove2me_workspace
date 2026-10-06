-- Generated from ChapterGravityIrrep.lean — solution of BookProof.ChapterGravityIrrep.irrep_reconstruction
import Mathlib
import Definitions.Def_ChapterGravityIrrep
open BookProof.ChapterGravityIrrep




open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin 3) (Fin 3) ℝ) :
    (1 / 2 : ℝ) • symTracelessPart M + (1 / 2 : ℝ) • antisymPart M
      + (1 / 3 : ℝ) • (M.trace) • (1 : Matrix (Fin 3) (Fin 3) ℝ) = M := by

  ext i j
  simp only [symTracelessPart, antisymPart, Matrix.add_apply, Matrix.sub_apply,
    Matrix.smul_apply, Matrix.transpose_apply, smul_eq_mul]
  ring
