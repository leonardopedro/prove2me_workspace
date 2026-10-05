-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.matrixModel_Psi_ne_zero
import Mathlib
import Definitions.Def_ChapterGaugeFixing
import Theorems.Thm_BookProof_GaugeFixing_Pm_ne_zero
import Theorems.Thm_BookProof_GaugeFixing_matrixModel_Psi
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : (Psi matrixModel : Mat2) ≠ 0 := by

  rw [matrixModel_Psi]; exact Pm_ne_zero
