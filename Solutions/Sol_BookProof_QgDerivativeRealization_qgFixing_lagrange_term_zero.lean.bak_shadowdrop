-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.qgFixing_lagrange_term_zero
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Theorems.Thm_BookProof_QgDerivativeRealization_qgSystemOf_gaugeField_eq_zero
import Theorems.Thm_BookProof_QgPhysicalSectorIdentity_lagrange_term_zero_of_fixing
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Definitions.Def_ChapterGaugeFixing
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval

set_option maxHeartbeats 1000000 in
theorem solution (T : TetradConfig) (E : DerivFields)
    (hE : Fixed T E) (mu nu a : Fin 4) :
    (qgSystemOf T E mu nu a).mul (1, 0) (1, 0) (qgSystemOf T E mu nu a).B
        (gaugeField (qgSystemOf T E mu nu a).toGaugeFixingSystem)
      = (qgSystemOf T E mu nu a).zero (2, 0) :=
  lagrange_term_zero_of_fixing (qgSystemOf T E mu nu a)
      (qgSystemOf_gaugeField_eq_zero T E hE mu nu a)
