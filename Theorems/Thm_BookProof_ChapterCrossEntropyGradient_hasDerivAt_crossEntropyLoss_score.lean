-- Generated from ChapterCrossEntropyGradient.lean — theorem BookProof.ChapterCrossEntropyGradient.hasDerivAt_crossEntropyLoss_score
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


theorem BookProof.ChapterCrossEntropyGradient.hasDerivAt_crossEntropyLoss_score (beta : ℝ) (s : Fin m → ℝ) (y i : Fin m) :
    HasDerivAt (fun t : ℝ => crossEntropyLoss beta (scorePerturb s i t) y)
      (crossEntropyGradient beta s y i) 0 := by sorry
