-- Generated from ChapterNavierStokesFockEsa.lean — theorem BookProof.NavierStokesFlow.FockOfFock.dGamma_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.FockOneParticleGap
open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.NavierStokesFlow

variable {M : Type*} [DecidableEq M]


open MeasureTheory



open FullEsa LagrangianEsa

theorem BookProof.NavierStokesFlow.FockOfFock.dGamma_not_bounded (ω : M → ℝ) (hω : ∀ C : ℝ, ∃ m, C < |ω m|) :
    ¬ ∃ C : ℝ, ∀ f : FockDom M, ‖dGamma ω f‖ ≤ C * ‖f‖ := by sorry
