-- Generated from ChapterSoftmaxJacobian.lean — theorem BookProof.ChapterSoftmaxJacobian.weightedVar_eq_sum_sq
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


theorem BookProof.ChapterSoftmaxJacobian.weightedVar_eq_sum_sq (beta : ℝ) (s x : Fin m → ℝ) (i : Fin m) :
    weightedVar beta s x
      = ∑ j, scoreSoftmax beta s j * (x j - ∑ l, scoreSoftmax beta s l * x l) ^ 2 := by sorry
