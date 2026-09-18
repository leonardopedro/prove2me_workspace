-- Generated from ChapterBddBelowFiberSumEsa.lean — solution of BookProof.BddBelowFiberSumEsa.qgFiberV_nonneg
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
open BookProof.BddBelowFiberSumEsa












open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {M alpha : ℝ} (halpha : 0 < alpha) {d : ℕ} (omega : Fin d → ℝ)
    (i : Option (Fin d)) (x : ℝ) : 0 ≤ qgFiberV M alpha omega i x := by

  cases i with
  | none => exact BookProof.Starobinsky.starobinskyV_nonneg halpha x
  | some i => exact mul_nonneg (sq_nonneg _) (sq_nonneg _)
