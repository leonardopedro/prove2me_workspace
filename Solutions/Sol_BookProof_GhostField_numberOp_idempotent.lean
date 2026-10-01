-- Generated from ChapterGhostField.lean — solution of BookProof.GhostField.numberOp_idempotent
import Mathlib
import Definitions.Def_ChapterGhostField
open BookProof.GhostField




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : numberOp * numberOp = numberOp := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [numberOp, psi, psiDag, Matrix.mul_apply, Fin.sum_univ_two]
