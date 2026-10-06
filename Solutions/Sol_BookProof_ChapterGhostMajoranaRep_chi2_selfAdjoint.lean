-- Generated from ChapterGhostMajoranaRep.lean — solution of BookProof.ChapterGhostMajoranaRep.chi2_selfAdjoint
import Mathlib
import Definitions.Def_ChapterGhostMajoranaRep
open BookProof.ChapterGhostMajoranaRep





open Matrix BookProof.GhostField

set_option maxHeartbeats 1000000 in
theorem solution : chi2ᴴ = chi2 := by

  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [chi2, psi, psiDag, Matrix.conjTranspose_apply]
