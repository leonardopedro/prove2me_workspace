-- Generated from ChapterCrossEntropyGradient.lean — theorem BookProof.ChapterCrossEntropyGradient.deriv_crossEntropyLoss_score
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterCrossEntropyGradient
import Definitions.Def_ChapterSoftmaxJacobian
open BookProof.ChapterCrossEntropyGradient


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterSoftmaxJacobian

variable {m : ℕ}


theorem BookProof.ChapterCrossEntropyGradient.deriv_crossEntropyLoss_score (beta : ℝ) (s : Fin m → ℝ) (y i : Fin m) :
    deriv (fun t : ℝ => crossEntropyLoss beta (scorePerturb s i t) y) 0
      = crossEntropyGradient beta s y i := by sorry
