-- Generated from ChapterGleasonPureMixed.lean — solution of BookProof.ChapterGleasonPureMixed.P0_Q_not_commute
import Mathlib
import Definitions.Def_ChapterGleasonPureMixed
open BookProof.ChapterGleasonPureMixed



open scoped BigOperators
open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : P0 * Q ≠ Q * P0 := by

  intro h
  have := congrFun (congrFun h 0) 1
  simp [P0, Q, Matrix.mul_apply, Fin.sum_univ_two] at this
