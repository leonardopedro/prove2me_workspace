-- Generated from ChapterGhostField.lean — solution of BookProof.GhostField.numberOp_selfAdjoint
import Mathlib
import Definitions.Def_ChapterGhostField
open BookProof.GhostField




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : numberOp = numberOpᴴ := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [numberOp, psi, psiDag, Matrix.conjTranspose_apply, Matrix.mul_apply, Fin.sum_univ_two]
