-- Generated from ChapterGhostMajoranaRep.lean — solution of BookProof.ChapterGhostMajoranaRep.psi_not_selfAdjoint
import Mathlib
import Definitions.Def_ChapterGhostMajoranaRep
open BookProof.ChapterGhostMajoranaRep





open Matrix BookProof.GhostField

set_option maxHeartbeats 1000000 in
theorem solution : psi ≠ psiᴴ := by

  intro h
  have h10 := congrFun (congrFun h 1) 0
  simp [psi, Matrix.conjTranspose_apply] at h10
