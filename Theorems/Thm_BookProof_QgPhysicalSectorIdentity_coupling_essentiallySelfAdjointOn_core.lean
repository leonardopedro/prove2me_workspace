-- Generated from ChapterQgPhysicalSectorIdentity.lean — theorem BookProof.QgPhysicalSectorIdentity.coupling_essentiallySelfAdjointOn_core
import Definitions.Def_ChapterGaugeFixing
import Definitions.Def_ChapterFockQuadraticEsa
import Definitions.Def_ChapterOperatorSeriesEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Mathlib
import Definitions.Def_ChapterQgPhysicalSectorIdentity
import Definitions.Def_ChapterA3n
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
open BookProof.ChapterA3n
open BookProof.DirectSumEsa
open BookProof.NavierStokesFlow.IkebeKato
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

theorem BookProof.QgPhysicalSectorIdentity.coupling_essentiallySelfAdjointOn_core {ω : ι → ℝ} (hω : ∀ i, 0 ≤ ω i)
    (h : ι × ι → ℂ)
    (hsum : Summable fun k : ι × ι => ‖h k‖ * (ω k.1 + ω k.2 + 2)) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((fockH hω (fun k : ι × ι => creIdx k.1) (fun k : ι × ι => annIdx k.2) h
          (fun p : ι × ι => deg_pair_le_two p.1 p.2)
          (coupling_weighted_summable h hsum)).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig ω)))) := by sorry
