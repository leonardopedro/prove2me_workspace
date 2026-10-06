-- Generated from ChapterPauliLorentz.lean — solution of BookProof.ChapterPauliLorentz.det_hermMat
import Mathlib
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz



open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (x : Fin 4 → ℝ) : (hermMat x).det = (mink x : ℂ) := by

  simp only [hermMat, Matrix.det_fin_two, Matrix.of_apply, Matrix.cons_val', Matrix.cons_val_zero,
    Matrix.cons_val_one, Matrix.empty_val', Matrix.cons_val_fin_one, mink]
  push_cast
  linear_combination (x 2 : ℂ) ^ 2 * Complex.I_sq
