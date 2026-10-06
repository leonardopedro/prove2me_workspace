-- Generated from ChapterGleasonPureMixed.lean — solution of BookProof.ChapterGleasonPureMixed.E_P0_Q
import Mathlib
import Definitions.Def_ChapterGleasonPureMixed
open BookProof.ChapterGleasonPureMixed



open scoped BigOperators
open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : E P0 Q = 1/2 := by

  simp [E, Q, P0, Matrix.trace, Fin.sum_univ_two]
