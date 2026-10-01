-- Generated from ChapterGhostField.lean — solution of BookProof.GhostField.numberOp_add_hole
import Mathlib
import Definitions.Def_ChapterGhostField
open BookProof.GhostField




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : numberOp + psi * psiDag = 1 := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [numberOp, psi, psiDag]
