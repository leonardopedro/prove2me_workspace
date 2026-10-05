-- Generated from ChapterEntropyTemperature.lean — solution of BookProof.ChapterEntropyTemperature.attentionEntropy_antitoneOn
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
import Theorems.Thm_BookProof_ChapterEntropyTemperature_hasDerivAt_attentionEntropy
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_varScore_nonneg
open BookProof.ChapterEntropyTemperature



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin m → ℝ) (i : Fin m) :
    AntitoneOn (fun b : ℝ => attentionEntropy b s) (Set.Ici (0 : ℝ)) := by

  have hdiff : Differentiable ℝ fun b : ℝ => attentionEntropy b s := fun b =>
    (hasDerivAt_attentionEntropy b s i).differentiableAt
  refine antitoneOn_of_deriv_nonpos (convex_Ici 0) hdiff.continuous.continuousOn
    (hdiff.differentiableOn.mono interior_subset) fun b hb => ?_
  have hb0 : (0 : ℝ) ≤ b := le_of_lt (by simpa using hb)
  rw [(hasDerivAt_attentionEntropy b s i).deriv, neg_nonpos]
  exact mul_nonneg hb0 (varScore_nonneg b s)
