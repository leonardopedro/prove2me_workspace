-- Generated from ChapterBddBelowFiberSumEsa.lean — solution of BookProof.BddBelowFiberSumEsa.contDiff_qgFiberV
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
open BookProof.BddBelowFiberSumEsa












open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.BddBelowWallEsa BookProof.WallEsaSemibounded BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) {d : ℕ} (omega : Fin d → ℝ) (i : Option (Fin d)) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (qgFiberV M alpha omega i) := by

  cases i with
  | none => exact BookProof.ScalaronEsa.contDiff_starobinskyV M alpha
  | some i => exact contDiff_const.mul (contDiff_id.pow 2)
