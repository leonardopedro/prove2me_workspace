-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.qgFixing_gaugeField_ne_zero_of_not_fixed
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Theorems.Thm_BookProof_QgDerivativeRealization_qgFixing_gaugeField_eq_zero_iff
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (mu : Fin 4) (f w : SpacetimePoly)
    (h : w ≠ pderiv mu f) :
    gaugeField (qgFixingSystem mu f w).toGaugeFixingSystem ≠ 0 := by

  rw [Ne, qgFixing_gaugeField_eq_zero_iff]
  exact h
