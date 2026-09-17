-- Generated from ChapterBddBelowFiberSumEsa.lean — theorem BookProof.BddBelowFiberSumEsa.contDiff_qgFiberV
import Mathlib
import Definitions.Def_ChapterBddBelowFiberSumEsa
open BookProof.BddBelowFiberSumEsa











open MeasureTheory
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.BddBelowWallEsa BookProof.WallEsaSemibounded BookProof.DirectSumEsa

noncomputable section

variable {ι : Type*}

theorem BookProof.BddBelowFiberSumEsa.contDiff_qgFiberV (M alpha : ℝ) {d : ℕ} (omega : Fin d → ℝ) (i : Option (Fin d)) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (qgFiberV M alpha omega i) := by sorry
