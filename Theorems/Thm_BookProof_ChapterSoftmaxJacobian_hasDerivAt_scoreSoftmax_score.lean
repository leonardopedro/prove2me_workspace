-- Generated from ChapterSoftmaxJacobian.lean — theorem BookProof.ChapterSoftmaxJacobian.hasDerivAt_scoreSoftmax_score
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


theorem BookProof.ChapterSoftmaxJacobian.hasDerivAt_scoreSoftmax_score (beta : ℝ) (s : Fin m → ℝ) (i j : Fin m) :
    HasDerivAt (fun t : ℝ => scoreSoftmax beta (scorePerturb s i t) j)
      (softmaxJacobian beta s i j) 0 := by sorry
