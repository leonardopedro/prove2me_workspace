-- Generated from ChapterQgPhysicalSectorIdentity.lean — theorem BookProof.QgPhysicalSectorIdentity.matrixModel_lagrange_term_zero
import Definitions.Def_ChapterFockQuadraticEsa
import Definitions.Def_ChapterOperatorSeriesEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Mathlib
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Definitions.Def_ChapterGaugeFixing
import Definitions.Def_ChapterSirkFinitePrecision
open BookProof.GaugeFixing
open BookProof.SirkFinitePrecision
open BookProof.SirkFinitePrecision.CertInterval
open BookProof.QgPhysicalSectorIdentity

variable {F : BiDegree → Type} (S : DerivativeVariableFixingSystem F)



open BookProof.GaugeFixing
open BookProof.FockQuadratic
open BookProof.OperatorSeries
open BookProof.FarisLavine
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal

theorem BookProof.QgPhysicalSectorIdentity.matrixModel_lagrange_term_zero
    (hfix : gaugeField matrixModel.toGaugeFixingSystem = 0) :
    matrixModel.mul (1, 0) (1, 0) matrixModel.B
        (gaugeField matrixModel.toGaugeFixingSystem) = 0 := by sorry
