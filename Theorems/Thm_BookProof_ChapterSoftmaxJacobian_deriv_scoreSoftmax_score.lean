-- Generated from ChapterSoftmaxJacobian.lean — theorem BookProof.ChapterSoftmaxJacobian.deriv_scoreSoftmax_score
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterSoftmaxJacobian
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxJacobian

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterSoftmaxJacobian.deriv_scoreSoftmax_score (beta : ℝ) (s : Fin m → ℝ) (i j : Fin m) :
    deriv (fun t : ℝ => scoreSoftmax beta (scorePerturb s i t) j) 0
      = softmaxJacobian beta s i j := by sorry
