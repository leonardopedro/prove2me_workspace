-- Generated from ChapterQgFourierElimination.lean — solution of BookProof.QgFourierElim.formValue_dGauge_elimConfig
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
open BookProof.QgFourierElim




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (z : Fin 3 × Fin 3 → ℂ) (mu nu i : Fin 3) :
    formValue k (dGaugeF mu nu i) (elimConfig k z) = 0 := by

  rw [formValue_dGauge, elimConfig_d, elimConfig_e, sub_self]
