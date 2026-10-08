-- Generated from ChapterSirkPerSystemFlowBound.lean — theorem BookProof.ChapterSirkPerSystemFlowBound.sirk_scheme_tendsto
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterSirkSpectralGeometry
import Definitions.Def_ChapterSirkPerSystem
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesDeficiency
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterNavierStokesHashimoto
import Definitions.Def_ChapterNavierStokesDiffHashimoto
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterNavierStokesLagrangianEsa
import Definitions.Def_ChapterNavierStokesLagrangianKatoRellich
import Mathlib
import Definitions.Def_ChapterSirkPerSystemFlowBound
import Definitions.Def_ChapterH9
import Definitions.Def_ChapterSirkEndToEnd
open BookProof.ChapterH9
open BookProof.ChapterSirkEndToEnd
open BookProof.ChapterSirkPerSystemFlowBound


noncomputable section

open Filter Topology


open BookProof.ChapterH4 BookProof.ChapterH6 BookProof.ChapterH9
open BookProof.ChapterSirkEndToEnd BookProof.ChapterSirkSpectralGeometry
open BookProof.ChapterSirkPerSystem
open BookProof.HashimotoShiftInvert BookProof.FarisLavine BookProof.EsaClosure
open BookProof.YangMillsFriedrichs BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.Starobinsky
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow.IkebeKato BookProof.NavierStokesFlow.NSHashimoto
open BookProof.NavierStokesFlow.DiffHashimoto BookProof.NavierStokesFlow.DifferentialL2
open BookProof.NavierStokesFlow.LagrangianEsa BookProof.NavierStokesFlow.LagrangianKatoRellich

variable {E G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]


theorem BookProof.ChapterSirkPerSystemFlowBound.sirk_scheme_tendsto {X : E →L[ℂ] E} {S : Set ℂ} {C Dmin h : ℝ} (hh : 0 < h)
    (hS : numRange X ⊆ S)
    {Gm : ℕ → Type*} [∀ m, NormedAddCommGroup (Gm m)] [∀ m, InnerProductSpace ℂ (Gm m)]
    [∀ m, CompleteSpace (Gm m)]
    (V : ∀ m, Gm m →L[ℂ] E) (s : ∀ m, RationalScheme E (Gm m))
    (hs : ∀ m, IsSirkScheme X (V m) S C Dmin h m (s m))
    (flow : E →L[ℂ] E) (hflow : ∀ m, flow = (s m).psiX) (v : E)
    (hv : ∀ m, V m ((V m).adjoint v) = v) :
    Tendsto (fun m => ‖flow v - sirkApprox (V m) (s m).psiB v‖) atTop (𝓝 0) := by sorry
