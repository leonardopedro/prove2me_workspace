-- Generated from ChapterNavierStokesFockEsa.lean — theorem BookProof.NavierStokesFlow.FockOfFock.intervalTwoLevel_inner_eq_integral
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.NavierStokesFlow

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {K : Type*} [DecidableEq K]


open MeasureTheory



open FullEsa LagrangianEsa

theorem BookProof.NavierStokesFlow.FockOfFock.intervalTwoLevel_inner_eq_integral (eps : K → ℝ) (v : FockOfFockDom ℕ K) :
    (inner ℂ ((v : FockOfFockL2 ℕ K))
        ((dGamma (intervalTwoLevelSymbol eps) v : FockOfFockDom ℕ K) : FockOfFockL2 ℕ K) : ℂ).re
      = (∫ ξ, extField ξ * (inner ℂ ((v : FockOfFockL2 ℕ K))
            ((numberDensityOp parcelDens ξ v : FockOfFockDom ℕ K) : FockOfFockL2 ℕ K) : ℂ).re)
        + (inner ℂ ((v : FockOfFockL2 ℕ K))
            ((dGamma (innerEnergySymbol eps) v : FockOfFockDom ℕ K) : FockOfFockL2 ℕ K)
              : ℂ).re := by sorry
