-- Generated from ChapterQgDerivativeRealization.lean — solution of BookProof.QgDerivativeRealization.qgFixing_L_gf_constraint_surface
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Theorems.Thm_BookProof_QgDerivativeRealization_qgSystemOf_gaugeField_eq_zero
import Theorems.Thm_BookProof_QgPhysicalSectorIdentity_L_gf_constraint_surface
open BookProof.QgDerivativeRealization




open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

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
