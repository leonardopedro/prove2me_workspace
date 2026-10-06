-- Generated from ChapterGhostMajoranaRep.lean — solution of BookProof.ChapterGhostMajoranaRep.psi_of_chi
import Mathlib
import Definitions.Def_ChapterGhostMajoranaRep
open BookProof.ChapterGhostMajoranaRep





open Matrix BookProof.GhostField

set_option maxHeartbeats 1000000 in
theorem solution : psi = (2 : ℂ)⁻¹ • (chi1 - Complex.I • chi2) := by

  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [chi1, chi2, psi, psiDag, Complex.I_mul_I] ; norm_num
