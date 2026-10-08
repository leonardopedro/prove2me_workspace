-- Generated from ChapterCrossEntropyGradient.lean — solution of BookProof.ChapterCrossEntropyGradient.deriv_crossEntropyLoss_score
import Mathlib
import Definitions.Def_ChapterCrossEntropyGradient
import Theorems.Thm_BookProof_ChapterCrossEntropyGradient_hasDerivAt_crossEntropyLoss_score
import Definitions.Def_ChapterSoftmaxJacobian
open BookProof.ChapterSoftmaxJacobian
open BookProof.ChapterCrossEntropyGradient



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (y i : Fin m) :
    deriv (fun t : ℝ => crossEntropyLoss beta (scorePerturb s i t) y) 0
      = crossEntropyGradient beta s y i := (hasDerivAt_crossEntropyLoss_score beta s y i).deriv
