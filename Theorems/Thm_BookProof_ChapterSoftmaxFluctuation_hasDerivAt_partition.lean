-- Generated from ChapterSoftmaxFluctuation.lean — theorem BookProof.ChapterSoftmaxFluctuation.hasDerivAt_partition
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterSoftmaxFluctuation
open BookProof.ChapterSoftmaxFluctuation

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterSoftmaxFluctuation.hasDerivAt_partition (beta : ℝ) (s : Fin m → ℝ) :
    HasDerivAt (fun b : ℝ => partition b s)
      (∑ l, s l * Real.exp (beta * s l)) beta := by sorry
