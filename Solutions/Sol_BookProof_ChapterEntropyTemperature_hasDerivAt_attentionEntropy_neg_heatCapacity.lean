-- Generated from ChapterEntropyTemperature.lean — solution of BookProof.ChapterEntropyTemperature.hasDerivAt_attentionEntropy_neg_heatCapacity
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
import Theorems.Thm_BookProof_ChapterEntropyTemperature_hasDerivAt_attentionEntropy
open BookProof.ChapterEntropyTemperature



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {beta : ℝ} (hbeta : beta ≠ 0)
    (s : Fin m → ℝ) (i : Fin m) :
    HasDerivAt (fun b : ℝ => attentionEntropy b s) (-(heatCapacity beta s / beta)) beta := by

  refine (hasDerivAt_attentionEntropy beta s i).congr_deriv ?_
  rw [heatCapacity]
  field_simp
