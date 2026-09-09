-- Generated from ChapterSirkDiffusiveDecay.lean — theorem BookProof.ChapterSirkDiffusiveDecay.norm_heatFlow_le
import Mathlib
import Definitions.Def_ChapterSirkDiffusiveDecay
open BookProof.ChapterSirkDiffusiveDecay









noncomputable section


open BookProof.ChapterH4
open Filter Topology NormedSpace

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterSirkDiffusiveDecay.norm_heatFlow_le (A : E →L[ℂ] E) {mu : ℝ} (hA : IsCoercive A mu) {t : ℝ} (ht : 0 ≤ t) :
    ‖heatFlow A t‖ ≤ Real.exp (-(mu * t)) := by sorry
