-- Generated from ChapterEntropyTemperature.lean — theorem BookProof.ChapterEntropyTemperature.heatCapacity_nonneg
import Definitions.Def_ChapterAttentionEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
open BookProof.ChapterEntropyTemperature


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}


theorem BookProof.ChapterEntropyTemperature.heatCapacity_nonneg (beta : ℝ) (s : Fin m → ℝ) : 0 ≤ heatCapacity beta s := by sorry
