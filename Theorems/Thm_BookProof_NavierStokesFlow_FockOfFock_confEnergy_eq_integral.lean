-- Generated from ChapterNavierStokesFockEsa.lean — theorem BookProof.NavierStokesFlow.FockOfFock.confEnergy_eq_integral
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock


open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]

theorem BookProof.NavierStokesFlow.FockOfFock.confEnergy_eq_integral (μ : Measure Ω) (w : Ω → ℝ) (dens : M → Ω → ℝ)
    (hint : ∀ m, Integrable (fun ξ => w ξ * dens m ξ) μ) (n : Conf M) :
    confEnergy (symbolOfIntegral μ w dens) n = ∫ ξ, w ξ * confDensity dens n ξ ∂μ := by sorry
