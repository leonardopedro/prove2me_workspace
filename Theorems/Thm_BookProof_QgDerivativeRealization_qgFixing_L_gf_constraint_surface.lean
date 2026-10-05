-- Generated from ChapterQgDerivativeRealization.lean — theorem BookProof.QgDerivativeRealization.qgFixing_L_gf_constraint_surface
import Definitions.Def_ChapterQuantumGravity3DGauge
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Mathlib
import Definitions.Def_ChapterQgDerivativeRealization
import Definitions.Def_ChapterGaugeFixing
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.GaugeFixing
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.QgDerivativeRealization



open MvPolynomial
open BookProof.GaugeFixing
open BookProof.QuantumGravity3DGauge
open BookProof.QgPhysicalSectorIdentity

theorem BookProof.QgDerivativeRealization.qgFixing_L_gf_constraint_surface (T : TetradConfig) (E : DerivFields)
    (hE : Fixed T E) (mu nu a : Fin 4) :
    (qgSystemOf T E mu nu a).s (p := 2) (g := -1)
        (Psi (qgSystemOf T E mu nu a).toGaugeFixingSystem)
      = (qgSystemOf T E mu nu a).sub (2, 0) ((qgSystemOf T E mu nu a).zero (2, 0))
          ((qgSystemOf T E mu nu a).mul (1, -1) (1, 1) (qgSystemOf T E mu nu a).c_bar
            (qgSystemOf T E mu nu a).c) := by sorry
