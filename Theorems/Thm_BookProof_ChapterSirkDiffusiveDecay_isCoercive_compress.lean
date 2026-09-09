-- Generated from ChapterSirkDiffusiveDecay.lean — theorem BookProof.ChapterSirkDiffusiveDecay.isCoercive_compress
import Mathlib
import Definitions.Def_ChapterSirkDiffusiveDecay
open BookProof.ChapterSirkDiffusiveDecay









noncomputable section


open BookProof.ChapterH4
open Filter Topology NormedSpace

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterSirkDiffusiveDecay.isCoercive_compress (V : F →L[ℂ] E) (A : E →L[ℂ] E) {mu : ℝ}
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ F) (hA : IsCoercive A mu) :
    IsCoercive (compress V A) mu := by sorry
