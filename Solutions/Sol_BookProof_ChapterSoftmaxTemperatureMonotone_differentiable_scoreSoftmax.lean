-- Generated from ChapterSoftmaxTemperatureMonotone.lean — solution of BookProof.ChapterSoftmaxTemperatureMonotone.differentiable_scoreSoftmax
import Mathlib
import Definitions.Def_ChapterSoftmaxTemperatureMonotone
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_hasDerivAt_scoreSoftmax
open BookProof.ChapterSoftmaxTemperatureMonotone



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin m → ℝ) (j : Fin m) :
    Differentiable ℝ fun b : ℝ => scoreSoftmax b s j :=
  fun b =>
    (hasDerivAt_scoreSoftmax b s j).differentiableAt
