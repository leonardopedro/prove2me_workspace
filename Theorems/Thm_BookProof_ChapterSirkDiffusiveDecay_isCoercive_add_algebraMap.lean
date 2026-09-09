-- Generated from ChapterSirkDiffusiveDecay.lean — theorem BookProof.ChapterSirkDiffusiveDecay.isCoercive_add_algebraMap
import Mathlib
import Definitions.Def_ChapterSirkDiffusiveDecay
open BookProof.ChapterSirkDiffusiveDecay









noncomputable section


open BookProof.ChapterH4
open Filter Topology NormedSpace

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

theorem BookProof.ChapterSirkDiffusiveDecay.isCoercive_add_algebraMap (B : E →L[ℂ] E) (mu : ℝ)
    (hB : ∀ x : E, 0 ≤ (inner ℂ x (B x) : ℂ).re) :
    IsCoercive (B + (algebraMap ℝ (E →L[ℂ] E)) mu) mu := by sorry
