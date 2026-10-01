-- Generated from ChapterGhostField.lean — solution of BookProof.GhostField.numberOp_eq
import Mathlib
import Definitions.Def_ChapterGhostField
open BookProof.GhostField




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : numberOp = !![1, 0; 0, 0] := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [numberOp, psi, psiDag, Matrix.mul_apply, Fin.sum_univ_two]
