-- Generated from ChapterNavierStokesFockEsa.lean — theorem BookProof.NavierStokesFlow.FockOfFock.hTwoLevel_oneParticle
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
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]


open MeasureTheory



open FullEsa LagrangianEsa

theorem BookProof.NavierStokesFlow.FockOfFock.hTwoLevel_oneParticle (ext : J → ℝ) (eps : K → ℝ) (j : J) (c : Conf K) :
    hTwoLevel ext eps (fockBasis (Finsupp.single (j, c) 1))
      = (((ext j + confEnergy eps c : ℝ)) : ℂ) • fockBasis (Finsupp.single (j, c) 1) := by sorry
