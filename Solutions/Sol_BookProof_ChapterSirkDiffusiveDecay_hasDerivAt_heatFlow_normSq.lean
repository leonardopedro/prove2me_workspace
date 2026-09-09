-- Generated from ChapterSirkDiffusiveDecay.lean — solution of BookProof.ChapterSirkDiffusiveDecay.hasDerivAt_heatFlow_normSq
import Mathlib
import Definitions.Def_ChapterSirkDiffusiveDecay
import Theorems.Thm_BookProof_ChapterSirkDiffusiveDecay_hasDerivAt_heatFlow_apply
open BookProof.ChapterSirkDiffusiveDecay










noncomputable section


open BookProof.ChapterH4
open Filter Topology NormedSpace

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (A : E →L[ℂ] E) (v : E) (t : ℝ) :
    HasDerivAt (fun s : ℝ => ‖heatFlow A s v‖ ^ 2)
      (-2 * (inner ℂ (heatFlow A t v) (A (heatFlow A t v)) : ℂ).re) t := by

  have hd := hasDerivAt_heatFlow_apply A v t
  have h := hd.inner ℂ hd
  have h2 := Complex.reCLM.hasFDerivAt.comp_hasDerivAt t h
  simp only [Function.comp_def, Complex.reCLM_apply, Complex.add_re, inner_neg_right,
    inner_neg_left, Complex.neg_re] at h2
  have hnorm : ∀ s : ℝ, ((inner ℂ (heatFlow A s v) (heatFlow A s v) : ℂ)).re
      = ‖heatFlow A s v‖ ^ 2 := by
    intro s
    simp [← Complex.ofReal_pow]
  have hcomm : (inner ℂ (A (heatFlow A t v)) (heatFlow A t v) : ℂ).re
      = (inner ℂ (heatFlow A t v) (A (heatFlow A t v)) : ℂ).re := by
    have h3 : (starRingEnd ℂ) (inner ℂ (heatFlow A t v) (A (heatFlow A t v)))
        = inner ℂ (A (heatFlow A t v)) (heatFlow A t v) := inner_conj_symm _ _
    rw [← h3, Complex.conj_re]
  simp only [hnorm, hcomm] at h2
  convert h2 using 1
  · rfl
  · rfl
  · ring
