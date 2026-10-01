-- Generated from ChapterGhostField.lean — solution of BookProof.GhostField.psiDag_sq
import Mathlib
import Definitions.Def_ChapterGhostField
open BookProof.GhostField




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : psiDag * psiDag = 0 := by

  ext i j; fin_cases i <;> fin_cases j <;> simp [psiDag, Matrix.mul_apply, Fin.sum_univ_two]
