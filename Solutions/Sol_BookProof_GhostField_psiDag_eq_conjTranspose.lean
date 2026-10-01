-- Generated from ChapterGhostField.lean — solution of BookProof.GhostField.psiDag_eq_conjTranspose
import Mathlib
import Definitions.Def_ChapterGhostField
open BookProof.GhostField




open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : psiDag = psiᴴ := by

  ext i j; fin_cases i <;> fin_cases j <;> simp [psi, psiDag, Matrix.conjTranspose_apply]
