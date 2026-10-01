-- Generated from ChapterGhostField.lean — solution of BookProof.GhostField.psi_sq
import Mathlib
import Definitions.Def_ChapterGhostField
open BookProof.GhostField




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : psi * psi = 0 := by

  ext i j; fin_cases i <;> fin_cases j <;> simp [psi, Matrix.mul_apply, Fin.sum_univ_two]
