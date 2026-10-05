-- Generated from ChapterQgPhysicalSectorIdentity.lean — theorem BookProof.QgPhysicalSectorIdentity.coupling_weighted_summable
import Definitions.Def_ChapterGaugeFixing
import Definitions.Def_ChapterFockQuadraticEsa
import Definitions.Def_ChapterOperatorSeriesEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesIkebeKato
import Mathlib
import Definitions.Def_ChapterQgPhysicalSectorIdentity
open BookProof.QgPhysicalSectorIdentity

variable {F : BiDegree → Type} (S : DerivativeVariableFixingSystem F)
variable {ι : Type*}



open BookProof.GaugeFixing
open BookProof.FockQuadratic
open BookProof.OperatorSeries
open BookProof.FarisLavine
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal

theorem BookProof.QgPhysicalSectorIdentity.coupling_weighted_summable {ω : ι → ℝ} (h : ι × ι → ℂ)
    (hsum : Summable fun k : ι × ι => ‖h k‖ * (ω k.1 + ω k.2 + 2)) :
    Summable fun k : ι × ι => ‖h k‖ * (wsum ω (creIdx k.1) + wsum ω (annIdx k.2) + 2) := by sorry
