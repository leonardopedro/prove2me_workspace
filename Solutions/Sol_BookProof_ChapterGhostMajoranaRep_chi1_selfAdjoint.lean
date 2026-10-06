-- Generated from ChapterGhostMajoranaRep.lean — solution of BookProof.ChapterGhostMajoranaRep.chi1_selfAdjoint
import Mathlib
import Definitions.Def_ChapterGhostMajoranaRep
open BookProof.ChapterGhostMajoranaRep





open Matrix BookProof.GhostField

set_option maxHeartbeats 1000000 in
theorem solution : chi1ᴴ = chi1 := by

  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [chi1, psi, psiDag, Matrix.conjTranspose_apply]
