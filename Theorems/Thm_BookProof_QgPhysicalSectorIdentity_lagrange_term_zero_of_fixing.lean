-- Generated from ChapterQgPhysicalSectorIdentity.lean — theorem BookProof.QgPhysicalSectorIdentity.lagrange_term_zero_of_fixing
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

theorem BookProof.QgPhysicalSectorIdentity.lagrange_term_zero_of_fixing
    (hfix : gaugeField S.toGaugeFixingSystem = S.toGaugeFixingSystem.zero (1, 0)) :
    S.mul (1, 0) (1, 0) S.B (gaugeField S.toGaugeFixingSystem) = S.zero (2, 0) := by sorry
