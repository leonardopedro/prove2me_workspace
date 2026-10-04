-- Generated from ChapterEntropyTemperature.lean — theorem BookProof.ChapterEntropyTemperature.heatCapacity_nonneg
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
import Definitions.Def_ChapterA4
open BookProof.ChapterEntropyTemperature

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterEntropyTemperature.heatCapacity_nonneg (beta : ℝ) (s : Fin m → ℝ) : 0 ≤ heatCapacity beta s := by sorry
