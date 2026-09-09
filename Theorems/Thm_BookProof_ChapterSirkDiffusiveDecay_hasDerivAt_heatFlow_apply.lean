-- Generated from ChapterSirkDiffusiveDecay.lean — theorem BookProof.ChapterSirkDiffusiveDecay.hasDerivAt_heatFlow_apply
import Mathlib
import Definitions.Def_ChapterSirkDiffusiveDecay
open BookProof.ChapterSirkDiffusiveDecay









noncomputable section


open BookProof.ChapterH4
open Filter Topology NormedSpace

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterSirkDiffusiveDecay.hasDerivAt_heatFlow_apply (A : E →L[ℂ] E) (v : E) (t : ℝ) :
    HasDerivAt (fun s : ℝ => heatFlow A s v) (-(A (heatFlow A t v))) t := by sorry
