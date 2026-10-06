-- Generated from ChapterPauliLorentz.lean — solution of BookProof.ChapterPauliLorentz.σ2_sq
import Mathlib
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz



open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution : σ2 * σ2 = 1 := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [σ2, Matrix.mul_apply, Fin.sum_univ_two, Complex.I_mul_I]
