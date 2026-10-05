-- Generated from ChapterCrossEntropyGradient.lean — theorem BookProof.ChapterCrossEntropyGradient.crossEntropyLoss_nonneg
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterCrossEntropyGradient
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterCrossEntropyGradient

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterCrossEntropyGradient.crossEntropyLoss_nonneg (beta : ℝ) (s : Fin m → ℝ) (y : Fin m) :
    0 ≤ crossEntropyLoss beta s y := by sorry
