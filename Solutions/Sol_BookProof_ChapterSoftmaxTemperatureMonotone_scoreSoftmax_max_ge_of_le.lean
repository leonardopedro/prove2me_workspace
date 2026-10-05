-- Generated from ChapterSoftmaxTemperatureMonotone.lean — solution of BookProof.ChapterSoftmaxTemperatureMonotone.scoreSoftmax_max_ge_of_le
import Mathlib
import Definitions.Def_ChapterSoftmaxTemperatureMonotone
import Theorems.Thm_BookProof_ChapterSoftmaxTemperatureMonotone_scoreSoftmax_monotone_of_max
open BookProof.ChapterSoftmaxTemperatureMonotone



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {beta gamma : ℝ} (hbg : beta ≤ gamma) (s : Fin m → ℝ)
    (j : Fin m) (hmax : ∀ l, s l ≤ s j) :
    scoreSoftmax beta s j ≤ scoreSoftmax gamma s j := scoreSoftmax_monotone_of_max s j hmax hbg
