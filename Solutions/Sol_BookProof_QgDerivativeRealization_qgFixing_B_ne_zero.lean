-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.qgFixing_B_ne_zero
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (mu : Fin 4) (f w : SpacetimePoly) :
    ((qgFixingSystem mu f w).B : Mat2R) ≠ 0 := by

  intro h
  have h00 := congrFun (congrFun h 0) 0
  simp [qgFixingSystem] at h00
