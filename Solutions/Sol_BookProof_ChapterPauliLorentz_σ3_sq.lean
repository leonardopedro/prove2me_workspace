-- Generated from ChapterPauliLorentz.lean — solution of BookProof.ChapterPauliLorentz.sigma3_sq
import Mathlib
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz



open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution : σ3 * σ3 = 1 := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [σ3, Matrix.mul_apply, Fin.sum_univ_two]
