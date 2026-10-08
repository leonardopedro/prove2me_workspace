-- Generated from ChapterEntropyTemperature.lean — theorem BookProof.ChapterEntropyTemperature.attentionEntropy_eq
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
import Definitions.Def_ChapterSoftmaxFluctuation
open BookProof.ChapterEntropyTemperature


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxFluctuation

variable {m : ℕ}


theorem BookProof.ChapterEntropyTemperature.attentionEntropy_eq (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    attentionEntropy beta s = logPartition beta s - beta * meanScore beta s := by sorry
