-- Generated from ChapterResolventMinMaxEquality.lean — solution of BookProof.ResolventLadderEq.stepUp_nonneg
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
theorem solution (c δ t : ℝ) : 0 ≤ stepUp c δ t := by

  have h : cutoff (c - δ / 2) (δ / 2) t ≤ 1 := min_le_left _ _
  rw [stepUp, cocutoff]
  linarith
