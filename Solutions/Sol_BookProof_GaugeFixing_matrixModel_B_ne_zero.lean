-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.matrixModel_B_ne_zero
import Mathlib
import Definitions.Def_ChapterGaugeFixing
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : (matrixModel.B : Mat2) ≠ 0 := by

  simp [matrixModel]
