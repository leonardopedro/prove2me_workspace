-- Generated from ChapterEntropyTemperature.lean — theorem BookProof.ChapterEntropyTemperature.hasDerivAt_attentionEntropy_neg_heatCapacity
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
import Definitions.Def_ChapterA4
open BookProof.ChapterEntropyTemperature

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterEntropyTemperature.hasDerivAt_attentionEntropy_neg_heatCapacity {beta : ℝ} (hbeta : beta ≠ 0)
    (s : Fin m → ℝ) (i : Fin m) :
    HasDerivAt (fun b : ℝ => attentionEntropy b s) (-(heatCapacity beta s / beta)) beta := by sorry
