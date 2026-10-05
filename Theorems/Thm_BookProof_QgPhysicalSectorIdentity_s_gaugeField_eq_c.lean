-- Generated from ChapterQgPhysicalSectorIdentity.lean — theorem BookProof.QgPhysicalSectorIdentity.s_gaugeField_eq_c
import Definitions.Def_ChapterFockQuadraticEsa
import Definitions.Def_ChapterOperatorSeriesEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Mathlib
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Definitions.Def_ChapterGaugeFixing
open BookProof.GaugeFixing
open BookProof.QgPhysicalSectorIdentity

variable {F : BiDegree → Type} (S : DerivativeVariableFixingSystem F)



open BookProof.GaugeFixing
open BookProof.FockQuadratic
open BookProof.OperatorSeries
open BookProof.FarisLavine
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal

theorem BookProof.QgPhysicalSectorIdentity.s_gaugeField_eq_c : S.s (gaugeField S.toGaugeFixingSystem) = S.c := by sorry
