-- Generated from ChapterNavierStokesFockEsa.lean — theorem BookProof.NavierStokesFlow.FockOfFock.hTwoLevel_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.NavierStokesFlow

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]


open MeasureTheory



open FullEsa LagrangianEsa

theorem BookProof.NavierStokesFlow.FockOfFock.hTwoLevel_hasZeroDeficiencyOn (ext : J → ℝ) (eps : K → ℝ) :
    HasZeroDeficiencyOn (FockOfFockDom J K) (hTwoLevel ext eps) := by sorry
