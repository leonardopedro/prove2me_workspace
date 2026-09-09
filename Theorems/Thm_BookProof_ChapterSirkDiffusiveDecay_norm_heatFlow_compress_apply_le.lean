-- Generated from ChapterSirkDiffusiveDecay.lean — theorem BookProof.ChapterSirkDiffusiveDecay.norm_heatFlow_compress_apply_le
import Mathlib
import Definitions.Def_ChapterSirkDiffusiveDecay
open BookProof.ChapterSirkDiffusiveDecay









noncomputable section


open BookProof.ChapterH4
open Filter Topology NormedSpace

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterSirkDiffusiveDecay.norm_heatFlow_compress_apply_le (V : F →L[ℂ] E) (A : E →L[ℂ] E) {mu : ℝ}
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ F) (hA : IsCoercive A mu) (x : F)
    {t : ℝ} (ht : 0 ≤ t) :
    ‖heatFlow (compress V A) t x‖ ≤ Real.exp (-(mu * t)) * ‖x‖ := by sorry
