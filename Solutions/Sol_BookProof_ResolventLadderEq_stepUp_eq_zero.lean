-- Generated from ChapterResolventMinMaxEquality.lean — solution of BookProof.ResolventLadderEq.stepUp_eq_zero
import Mathlib
import Definitions.Def_ChapterResolventMinMaxEquality
open BookProof.ResolventLadderEq



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.MinMaxSpectrum
open BookProof.ResolventLadder
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {c δ t : ℝ} (hδ : 0 < δ) (h : t ≤ c - δ) : stepUp c δ t = 0 := by

  have h1 : t ≤ c - δ / 2 - δ / 2 := by linarith
  rw [stepUp, cocutoff, cutoff_eq_one (by linarith) h1, sub_self]
