-- Generated from ChapterCrossEntropyGradient.lean — theorem BookProof.ChapterCrossEntropyGradient.crossEntropyLoss_eq_zero_iff
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


theorem BookProof.ChapterCrossEntropyGradient.crossEntropyLoss_eq_zero_iff (beta : ℝ) (s : Fin m → ℝ) (y : Fin m) :
    crossEntropyLoss beta s y = 0 ↔ scoreSoftmax beta s y = 1 := by sorry
