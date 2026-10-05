-- Generated from ChapterSoftmaxFluctuation.lean — theorem BookProof.ChapterSoftmaxFluctuation.hasDerivAt_scoreSoftmax
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


theorem BookProof.ChapterSoftmaxFluctuation.hasDerivAt_scoreSoftmax (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    HasDerivAt (fun b : ℝ => scoreSoftmax b s j)
      (scoreSoftmax beta s j * (s j - meanScore beta s)) beta := by sorry
