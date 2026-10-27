-- Generated from ChapterQgFourierElimination.lean — solution of BookProof.QgFourierElim.formValue_gauge3d_elimConfig
import Mathlib
import Definitions.Def_ChapterQgFourierElimination
open BookProof.QgFourierElim




open BookProof.ScalaronFiberFL BookProof.ScalaronOuterFockFL
open BookProof.QgVielbeinModeInstance BookProof.QgContinuumModeInstance
open BookProof.QgBrstDerivativeGauge
open BookProof.FarisLavine BookProof.QgOuterFockCoreFL
open BookProof.QgVielbeinScalaronGaugeFL

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (k : Mom) (z : Fin 3 × Fin 3 → ℂ) (i : Fin 3) :
    formValue k (gauge3dF i) (elimConfig k z)
      = ∑ mu : Fin 3, Complex.I * ((k mu : ℤ) : ℂ) * z (mu, i) := by

  rw [formValue_gauge3d]
  exact Finset.sum_congr rfl fun mu _ => by rw [elimConfig_e]
