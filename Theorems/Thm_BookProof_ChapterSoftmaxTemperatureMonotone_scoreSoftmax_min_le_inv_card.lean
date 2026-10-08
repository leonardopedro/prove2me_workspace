-- Generated from ChapterSoftmaxTemperatureMonotone.lean — theorem BookProof.ChapterSoftmaxTemperatureMonotone.scoreSoftmax_min_le_inv_card
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterSoftmaxTemperatureMonotone
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxTemperatureMonotone


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterSoftmaxTemperatureMonotone.scoreSoftmax_min_le_inv_card {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ) (i : Fin m)
    (hmin : ∀ l, s i ≤ s l) : scoreSoftmax beta s i ≤ 1 / (m : ℝ) := by sorry
