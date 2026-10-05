-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.matrixModel_c_ne_zero
import Mathlib
import Definitions.Def_ChapterGaugeFixing
import Theorems.Thm_BookProof_GaugeFixing_Qm_ne_zero
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : (matrixModel.c : Mat2) ≠ 0 := by

  simpa [matrixModel] using Qm_ne_zero
