-- Generated from ChapterNavierStokesFockParcels.lean — theorem BookProof.NavierStokesFlow.FockLagrangian.bigState_symbol_ge
import Mathlib
import Definitions.Def_ChapterNavierStokesFockParcels
import Definitions.Def_ChapterNavierStokesThreeComponent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesFockLagrangian
open BookProof.NavierStokesFlow.ThreeComponent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockLagrangian

variable {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory



open FullEsa FockContinuum

theorem BookProof.NavierStokesFlow.FockLagrangian.bigState_symbol_ge {K : ℝ} (hK : 1 ≤ K) :
    ∀ᵐ x ∂fockR, ((bigState K : Lp ℂ 2 fockR) : ParcelConf ℝ → ℂ) x ≠ 0
        → K ≤ |momFock.total x| := by
  filter_upwards [bigState_coeFn K] with x hx hne
  rw [hx] at hne
  have hmem : x ∈ bigSet K := by sorry
