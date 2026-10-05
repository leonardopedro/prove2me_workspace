-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.fixed_iff
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (T : TetradConfig) (E : DerivFields) :
    Fixed T E ↔ ∀ mu nu a, E mu nu a = pderiv mu (T.comp nu a) := by

  constructor
  · intro h mu nu a
    have := h mu nu a
    rw [gaugeFieldPoly, sub_eq_zero] at this
    exact this
  · intro h mu nu a
    rw [gaugeFieldPoly, h, sub_self]
