-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.smul_one_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (f : SpacetimePoly) : f • (1 : Mat2R) = 0 ↔ f = 0 := by

  constructor
  · intro h
    have h00 := congrFun (congrFun h 0) 0
    simpa [Matrix.smul_apply, Matrix.one_apply] using h00
  · rintro rfl; simp
