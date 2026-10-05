-- Generated from ChapterNavierStokesFockEsa.lean — solution of BookProof.NavierStokesFlow.FockOfFock.hTwoLevel_isSymmetricDom
import Mathlib
import Definitions.Def_ChapterNavierStokesFockEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock



open MeasureTheory



open FullEsa LagrangianEsa

variable {M : Type*} [DecidableEq M]
variable {M : Type*} [DecidableEq M] {Ω : Type*} [MeasurableSpace Ω]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]

set_option maxHeartbeats 1000000 in
omit [DecidableEq J] [DecidableEq K] in
theorem solution (ext : J → ℝ) (eps : K → ℝ) :
    IsSymmetricDom (hTwoLevel ext eps) := dGamma_isSymmetricDom _
