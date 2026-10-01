-- Generated from ChapterGhostField.lean — solution of BookProof.GhostField.car
import Mathlib
import Definitions.Def_ChapterGhostField
open BookProof.GhostField




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : psi * psiDag + psiDag * psi = 1 := by

  ext i j; fin_cases i <;> fin_cases j <;>
    simp [psi, psiDag]
