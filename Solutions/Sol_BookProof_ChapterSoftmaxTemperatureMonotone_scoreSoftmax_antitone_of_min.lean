-- Generated from ChapterSoftmaxTemperatureMonotone.lean — solution of BookProof.ChapterSoftmaxTemperatureMonotone.scoreSoftmax_antitone_of_min
import Mathlib
import Definitions.Def_ChapterSoftmaxTemperatureMonotone
import Theorems.Thm_BookProof_ChapterSoftmaxTemperatureMonotone_deriv_scoreSoftmax_beta
import Theorems.Thm_BookProof_ChapterSoftmaxTemperatureMonotone_min_le_meanScore
import Theorems.Thm_BookProof_ChapterSoftmaxTemperatureMonotone_differentiable_scoreSoftmax
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_nonneg
open BookProof.ChapterSoftmaxTemperatureMonotone



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (s : Fin m → ℝ) (i : Fin m) (hmin : ∀ l, s i ≤ s l) :
    Antitone fun b : ℝ => scoreSoftmax b s i := by

  refine antitone_of_deriv_nonpos (differentiable_scoreSoftmax s i) fun b => ?_
  rw [deriv_scoreSoftmax_beta b s i]
  have hmean : s i ≤ meanScore b s := min_le_meanScore b s i hmin
  exact mul_nonpos_of_nonneg_of_nonpos (scoreSoftmax_nonneg b s i) (by linarith)
