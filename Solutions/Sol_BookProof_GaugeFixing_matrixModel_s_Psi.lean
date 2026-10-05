-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.matrixModel_s_Psi
import Mathlib
import Definitions.Def_ChapterGaugeFixing
import Theorems.Thm_BookProof_GaugeFixing_matrixModel_Psi
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : (sTop matrixModel (Psi matrixModel) : Mat2) = 1 := by

  change sMat (-1) (Psi matrixModel) = 1
  rw [show (Psi matrixModel : Mat2) = Pm from matrixModel_Psi]
  exact sMat_Pm
