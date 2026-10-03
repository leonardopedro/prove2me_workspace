-- Generated from ChapterNavierStokesFockEsa.lean — theorem BookProof.NavierStokesFlow.FockOfFock.confEnergy_zero
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

theorem BookProof.NavierStokesFlow.FockOfFock.confEnergy_zero (ω : M → ℝ) : confEnergy ω (0 : Conf M) = 0 := by sorry
