-- Generated from ChapterSoftmaxTemperatureMonotone.lean — theorem BookProof.ChapterSoftmaxTemperatureMonotone.scoreSoftmax_max_ge_inv_card
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


theorem BookProof.ChapterSoftmaxTemperatureMonotone.scoreSoftmax_max_ge_inv_card {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ) (j : Fin m)
    (hmax : ∀ l, s l ≤ s j) : 1 / (m : ℝ) ≤ scoreSoftmax beta s j := by sorry
