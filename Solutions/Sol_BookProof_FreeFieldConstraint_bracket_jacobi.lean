-- Generated from ChapterFreeFieldConstraint.lean — solution of BookProof.FreeFieldConstraint.bracket_jacobi
import Mathlib
import Definitions.Def_ChapterFreeFieldConstraint
open BookProof.FreeFieldConstraint




variable {R : Type*} [Ring R]

set_option maxHeartbeats 1000000 in
theorem solution (a b c : R) :
    bracket (bracket a b) c + bracket (bracket b c) a + bracket (bracket c a) b = 0 := by

  simp only [bracket]; noncomm_ring
