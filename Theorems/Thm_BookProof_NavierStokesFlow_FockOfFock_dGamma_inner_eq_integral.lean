-- Generated from ChapterNavierStokesFockEsa.lean — theorem BookProof.NavierStokesFlow.FockOfFock.dGamma_inner_eq_integral
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.NavierStokesFlow

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]


open MeasureTheory



open FullEsa LagrangianEsa

theorem BookProof.NavierStokesFlow.FockOfFock.dGamma_inner_eq_integral (μ : Measure Ω) (w : Ω → ℝ) (dens : M → Ω → ℝ)
    (hint : ∀ m, Integrable (fun ξ => w ξ * dens m ξ) μ) (v : FockDom M) :
    (inner ℂ ((v : FockL2 M)) ((dGamma (symbolOfIntegral μ w dens) v : FockDom M) : FockL2 M)
        : ℂ).re
      = ∫ ξ, w ξ * (inner ℂ ((v : FockL2 M))
          ((numberDensityOp dens ξ v : FockDom M) : FockL2 M) : ℂ).re ∂μ := by sorry
