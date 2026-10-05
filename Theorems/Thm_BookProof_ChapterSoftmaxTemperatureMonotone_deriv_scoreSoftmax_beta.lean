-- Generated from ChapterSoftmaxTemperatureMonotone.lean — theorem BookProof.ChapterSoftmaxTemperatureMonotone.deriv_scoreSoftmax_beta
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterSoftmaxTemperatureMonotone
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxTemperatureMonotone

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterSoftmaxTemperatureMonotone.deriv_scoreSoftmax_beta (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    deriv (fun b : ℝ => scoreSoftmax b s j) beta
      = scoreSoftmax beta s j * (s j - meanScore beta s) := by sorry
