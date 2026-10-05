-- Generated from ChapterQgDerivativeRealization.lean — theorem BookProof.QgDerivativeRealization.qgSystemOf_gaugeField_eq_zero
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Definitions.Def_ChapterGaugeFixing
open BookProof.GaugeFixing
open BookProof.QgDerivativeRealization



open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

theorem BookProof.QgDerivativeRealization.qgSystemOf_gaugeField_eq_zero (T : TetradConfig) (E : DerivFields)
    (hE : Fixed T E) (mu nu a : Fin 4) :
    gaugeField (qgSystemOf T E mu nu a).toGaugeFixingSystem
      = (qgSystemOf T E mu nu a).toGaugeFixingSystem.zero (1, 0) := by sorry
