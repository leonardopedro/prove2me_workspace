-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.jetDeriv_fixed
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

set_option maxHeartbeats 1000000 in
theorem solution (T : TetradConfig) : Fixed T (jetDeriv T) := by

  intro mu nu a
  simp [gaugeFieldPoly, jetDeriv]
