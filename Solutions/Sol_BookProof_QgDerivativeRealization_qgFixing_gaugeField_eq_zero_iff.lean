-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.qgFixing_gaugeField_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Theorems.Thm_BookProof_QgDerivativeRealization_smul_one_eq_zero_iff
import Theorems.Thm_BookProof_QgDerivativeRealization_qgFixing_gaugeField
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (mu : Fin 4) (f w : SpacetimePoly) :
    gaugeField (qgFixingSystem mu f w).toGaugeFixingSystem = 0 ↔ w = pderiv mu f := by

  rw [qgFixing_gaugeField, smul_one_eq_zero_iff, sub_eq_zero]
