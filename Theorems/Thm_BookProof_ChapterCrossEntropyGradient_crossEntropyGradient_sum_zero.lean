-- Generated from ChapterCrossEntropyGradient.lean — theorem BookProof.ChapterCrossEntropyGradient.crossEntropyGradient_sum_zero
import Mathlib
import Definitions.Def_ChapterCrossEntropyGradient
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterCrossEntropyGradient

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterCrossEntropyGradient.crossEntropyGradient_sum_zero (beta : ℝ) (s : Fin m → ℝ) (y : Fin m) :
    ∑ i, crossEntropyGradient beta s y i = 0 := by sorry
