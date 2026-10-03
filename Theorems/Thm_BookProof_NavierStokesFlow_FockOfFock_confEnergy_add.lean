-- Generated from ChapterNavierStokesFockEsa.lean — theorem BookProof.NavierStokesFlow.FockOfFock.confEnergy_add
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

variable {M : Type*} [DecidableEq M]


open MeasureTheory



open FullEsa LagrangianEsa

theorem BookProof.NavierStokesFlow.FockOfFock.confEnergy_add (ω₁ ω₂ : M → ℝ) (n : Conf M) :
    confEnergy (ω₁ + ω₂) n = confEnergy ω₁ n + confEnergy ω₂ n := by sorry
