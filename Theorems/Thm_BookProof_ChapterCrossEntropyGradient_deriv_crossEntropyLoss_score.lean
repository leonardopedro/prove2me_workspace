-- Generated from ChapterCrossEntropyGradient.lean — theorem BookProof.ChapterCrossEntropyGradient.deriv_crossEntropyLoss_score
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterCrossEntropyGradient
open BookProof.ChapterCrossEntropyGradient

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterCrossEntropyGradient.deriv_crossEntropyLoss_score (beta : ℝ) (s : Fin m → ℝ) (y i : Fin m) :
    deriv (fun t : ℝ => crossEntropyLoss beta (scorePerturb s i t) y) 0
      = crossEntropyGradient beta s y i := by sorry
