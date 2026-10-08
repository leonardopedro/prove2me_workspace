-- Generated from ChapterCrossEntropyGradient.lean — theorem BookProof.ChapterCrossEntropyGradient.crossEntropyGradient_target_nonpos
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterCrossEntropyGradient
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterCrossEntropyGradient


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterCrossEntropyGradient.crossEntropyGradient_target_nonpos {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    (y : Fin m) : crossEntropyGradient beta s y y ≤ 0 := by sorry
