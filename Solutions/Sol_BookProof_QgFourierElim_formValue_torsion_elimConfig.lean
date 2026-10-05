-- Generated from ChapterQgFourierElimination.lean — solution of BookProof.QgFourierElim.formValue_torsion_elimConfig
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
    formValue k (torsionF mu nu i) (elimConfig k z)
      = Complex.I * (((k mu : ℤ) : ℂ) * z (nu, i) - ((k nu : ℤ) : ℂ) * z (mu, i)) := by

  rw [formValue_torsion, elimConfig_d, elimConfig_d]
  ring
