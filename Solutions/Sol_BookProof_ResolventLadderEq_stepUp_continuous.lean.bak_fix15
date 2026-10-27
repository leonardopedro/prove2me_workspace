-- Generated from ChapterResolventMinMaxEquality.lean — solution of BookProof.ResolventLadderEq.stepUp_continuous
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
theorem solution (c δ : ℝ) : Continuous (stepUp c δ) := cocutoff_continuous _ _
