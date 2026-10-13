-- Generated from ChapterQgPhysicalSectorIdentity.lean — solution of BookProof.QgPhysicalSectorIdentity.matrixModel_lagrange_term_zero
import Mathlib
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Definitions.Def_ChapterFockQuadraticEsa
import Definitions.Def_ChapterOperatorSeriesEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterGaugeFixing
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.QgPhysicalSectorIdentity




open BookProof.GaugeFixing
open BookProof.FockQuadratic
open BookProof.OperatorSeries
open BookProof.FarisLavine
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval

variable {F : BiDegree → Type} (S : DerivativeVariableFixingSystem F)

set_option maxHeartbeats 1000000 in
theorem solution
    (hfix : gaugeField matrixModel.toGaugeFixingSystem = 0) :
    matrixModel.mul (1, 0) (1, 0) matrixModel.B
        (gaugeField matrixModel.toGaugeFixingSystem) = 0 := by

  rw [hfix]
  exact matrixModel.mul_zero_right matrixModel.B
