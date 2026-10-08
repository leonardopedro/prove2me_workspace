-- Generated from ChapterSoftmaxJacobian.lean — theorem BookProof.ChapterSoftmaxJacobian.deriv_logPartition_score
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterSoftmaxJacobian
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxFluctuation
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxJacobian


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
open BookProof.ChapterSoftmaxFluctuation

variable {m : ℕ}


theorem BookProof.ChapterSoftmaxJacobian.deriv_logPartition_score (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    deriv (fun t : ℝ => logPartition beta (scorePerturb s i t)) 0
      = beta * scoreSoftmax beta s i := by sorry
