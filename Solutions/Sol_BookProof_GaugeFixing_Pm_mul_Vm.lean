-- Generated from ChapterGaugeFixing.lean — solution of BookProof.GaugeFixing.Pm_mul_Vm
import Mathlib
import Definitions.Def_ChapterGaugeFixing
open BookProof.GaugeFixing

variable {F : BiDegree → Type} (S : GaugeFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution : Pm * Vm = Pm := by

  ext i j; fin_cases i <;> fin_cases j <;> simp [Pm, Vm, Matrix.mul_apply, Fin.sum_univ_two]
