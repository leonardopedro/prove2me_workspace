-- Generated from ChapterSirkDiffusiveDecay.lean — solution of BookProof.ChapterSirkDiffusiveDecay.heatFlow_apply_comm
import Mathlib
import Definitions.Def_ChapterSirkDiffusiveDecay
open BookProof.ChapterSirkDiffusiveDecay










noncomputable section


open BookProof.ChapterH4
open Filter Topology NormedSpace

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : E →L[ℂ] E) (t : ℝ) (v : E) :
    heatFlow A t (A v) = A (heatFlow A t v) := by

  have hcomm : exp ((-t) • A) * A = A * exp ((-t) • A) :=
    (((Commute.refl A).smul_right (-t)).exp_right.eq).symm
  have := congrArg (fun T : E →L[ℂ] E => T v) hcomm
  simpa [heatFlow, ContinuousLinearMap.mul_apply] using this
