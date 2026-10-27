-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.dMatR_smul_one
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (mu : Fin 4) (f : SpacetimePoly) :
    dMatR mu (f • (1 : Mat2R)) = (pderiv mu f) • (1 : Mat2R) := by

  ext i j
  fin_cases i <;> fin_cases j <;> simp [dMatR, Matrix.smul_apply]
