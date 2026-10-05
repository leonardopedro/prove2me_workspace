-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.matrixModel_Psi
import Mathlib
import Definitions.Def_ChapterGaugeFixing
import Theorems.Thm_BookProof_GaugeFixing_Pm_mul_Vm
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : (Psi matrixModel : Mat2) = Pm := by

  simp [Psi, gaugeField, matrixModel, Pm_mul_Vm]
