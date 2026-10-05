-- Generated from ChapterResolventMinMaxEquality.lean — solution of BookProof.ResolventLadderEq.stepUp_le_one
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
open BookProof.ResolventLadderEq



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum
open BookProof.ResolventLadder
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (c δ t : ℝ) : stepUp c δ t ≤ 1 := by

  have h : 0 ≤ cutoff (c - δ / 2) (δ / 2) t := le_min (by norm_num) (le_max_left _ _)
  rw [stepUp, cocutoff]
  linarith
