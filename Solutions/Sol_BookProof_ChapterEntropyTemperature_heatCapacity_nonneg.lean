-- Generated from ChapterEntropyTemperature.lean — solution of BookProof.ChapterEntropyTemperature.heatCapacity_nonneg
import Mathlib
import Definitions.Def_ChapterEntropyTemperature
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_varScore_nonneg
open BookProof.ChapterEntropyTemperature



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) : 0 ≤ heatCapacity beta s := mul_nonneg (sq_nonneg _) (varScore_nonneg beta s)
