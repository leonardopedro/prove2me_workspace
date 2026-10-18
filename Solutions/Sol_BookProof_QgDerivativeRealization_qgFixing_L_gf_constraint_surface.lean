-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.qgFixing_L_gf_constraint_surface
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Theorems.Thm_BookProof_QgPhysicalSectorIdentity_L_gf_constraint_surface
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
    (qgSystemOf T E mu nu a).s (p := 2) (g := -1)
        (Psi (qgSystemOf T E mu nu a).toGaugeFixingSystem)
      = (qgSystemOf T E mu nu a).sub (2, 0) ((qgSystemOf T E mu nu a).zero (2, 0))
          ((qgSystemOf T E mu nu a).mul (1, -1) (1, 1) (qgSystemOf T E mu nu a).c_bar
            (qgSystemOf T E mu nu a).c) :=
  L_gf_constraint_surface (qgSystemOf T E mu nu a)
      (qgSystemOf_gaugeField_eq_zero T E hE mu nu a)
