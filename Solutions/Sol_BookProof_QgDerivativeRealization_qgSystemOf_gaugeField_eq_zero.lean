-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.qgSystemOf_gaugeField_eq_zero
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Theorems.Thm_BookProof_QgDerivativeRealization_fixed_iff
import Theorems.Thm_BookProof_QgDerivativeRealization_qgFixing_gaugeField_eq_zero_iff
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (T : TetradConfig) (E : DerivFields)
    (hE : Fixed T E) (mu nu a : Fin 4) :
    gaugeField (qgSystemOf T E mu nu a).toGaugeFixingSystem
      = (qgSystemOf T E mu nu a).toGaugeFixingSystem.zero (1, 0) := by

  change gaugeField (qgFixingSystem mu (T.comp nu a) (E mu nu a)).toGaugeFixingSystem = 0
  rw [qgFixing_gaugeField_eq_zero_iff]
  exact (fixed_iff T E).1 hE mu nu a
