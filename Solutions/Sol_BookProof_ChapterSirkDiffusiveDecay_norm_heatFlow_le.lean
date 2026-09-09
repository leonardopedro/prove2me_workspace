-- Generated from ChapterSirkDiffusiveDecay.lean — solution of BookProof.ChapterSirkDiffusiveDecay.norm_heatFlow_le
import Mathlib
import Definitions.Def_ChapterSirkDiffusiveDecay
import Theorems.Thm_BookProof_ChapterSirkDiffusiveDecay_norm_heatFlow_apply_le
open BookProof.ChapterSirkDiffusiveDecay










noncomputable section


open BookProof.ChapterH4
open Filter Topology NormedSpace

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : E →L[ℂ] E) {mu : ℝ} (hA : IsCoercive A mu) {t : ℝ} (ht : 0 ≤ t) :
    ‖heatFlow A t‖ ≤ Real.exp (-(mu * t)) :=
  ContinuousLinearMap.opNorm_le_bound _ (Real.exp_pos _).le
      fun v => norm_heatFlow_apply_le A hA v ht
