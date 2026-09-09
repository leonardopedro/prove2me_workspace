-- Generated from ChapterSirkDiffusiveDecay.lean — solution of BookProof.ChapterSirkDiffusiveDecay.isCoercive_compress
import Mathlib
import Definitions.Def_ChapterSirkDiffusiveDecay
import Theorems.Thm_BookProof_ChapterSirkDiffusiveDecay_norm_embedding
open BookProof.ChapterSirkDiffusiveDecay










noncomputable section


open BookProof.ChapterH4
open Filter Topology NormedSpace

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (V : F →L[ℂ] E) (A : E →L[ℂ] E) {mu : ℝ}
    (hVV : V.adjoint.comp V = ContinuousLinearMap.id ℂ F) (hA : IsCoercive A mu) :
    IsCoercive (compress V A) mu := by

  intro x
  have hinner : (inner ℂ x (compress V A x) : ℂ) = inner ℂ (V x) (A (V x)) := by
    simp [compress, ContinuousLinearMap.adjoint_inner_right]
  rw [hinner, ← norm_embedding V hVV x]
  exact hA (V x)
