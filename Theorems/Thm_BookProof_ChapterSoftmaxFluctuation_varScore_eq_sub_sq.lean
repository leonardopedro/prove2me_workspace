-- Generated from ChapterSoftmaxFluctuation.lean — theorem BookProof.ChapterSoftmaxFluctuation.varScore_eq_sub_sq
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterSoftmaxFluctuation
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxFluctuation

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterSoftmaxFluctuation.varScore_eq_sub_sq (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    varScore beta s = (∑ l, scoreSoftmax beta s l * s l ^ 2) - meanScore beta s ^ 2 := by sorry
