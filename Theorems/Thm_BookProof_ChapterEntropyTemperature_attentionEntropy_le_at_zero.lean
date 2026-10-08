-- Generated from ChapterEntropyTemperature.lean — theorem BookProof.ChapterEntropyTemperature.attentionEntropy_le_at_zero
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
open BookProof.ChapterEntropyTemperature


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}


theorem BookProof.ChapterEntropyTemperature.attentionEntropy_le_at_zero (s : Fin m → ℝ) (i : Fin m) {beta : ℝ}
    (hbeta : 0 ≤ beta) : attentionEntropy beta s ≤ attentionEntropy 0 s := by sorry
