-- Generated from ChapterGravityIrrep.lean — solution of BookProof.ChapterGravityIrrep.frob_symTraceless_antisym
import Mathlib
import Definitions.Def_ChapterGravityIrrep
open BookProof.ChapterGravityIrrep




open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (M : Matrix (Fin 3) (Fin 3) ℝ) :
    frobInner (symTracelessPart M) (antisymPart M) = 0 := by

  simp only [frobInner, symTracelessPart, antisymPart, Matrix.add_apply, Matrix.sub_apply,
    Matrix.smul_apply, Matrix.transpose_apply, Matrix.one_apply, smul_eq_mul,
    Fin.sum_univ_three]
  norm_num [Fin.ext_iff]
  ring
