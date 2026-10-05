-- Generated from ChapterCrossEntropyGradient.lean — theorem BookProof.ChapterCrossEntropyGradient.crossEntropyGradient_other_nonneg
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


theorem BookProof.ChapterCrossEntropyGradient.crossEntropyGradient_other_nonneg {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    {y i : Fin m} (h : i ≠ y) : 0 ≤ crossEntropyGradient beta s y i := by sorry
