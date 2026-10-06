-- Generated from ChapterGhostMajoranaRep.lean — solution of BookProof.ChapterGhostMajoranaRep.chi_anticomm
import Mathlib
import Definitions.Def_ChapterGhostMajoranaRep
open BookProof.ChapterGhostMajoranaRep





open Matrix BookProof.GhostField

set_option maxHeartbeats 1000000 in
theorem solution : chi1 * chi2 + chi2 * chi1 = 0 := by

  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [chi1, chi2, psi, psiDag]
