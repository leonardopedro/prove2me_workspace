-- Generated from ChapterEntropyTemperature.lean — theorem BookProof.ChapterEntropyTemperature.attentionEntropy_eq
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
open BookProof.ChapterEntropyTemperature

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterEntropyTemperature.attentionEntropy_eq (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    attentionEntropy beta s = logPartition beta s - beta * meanScore beta s := by sorry
