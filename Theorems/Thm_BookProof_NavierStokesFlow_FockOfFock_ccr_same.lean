-- Generated from ChapterNavierStokesFockSpace.lean — theorem BookProof.NavierStokesFlow.FockOfFock.ccr_same
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.NavierStokesFlow.FullEsa
variable {ι : Type*}














variable {ι : Type*}











variable {M : Type*} [DecidableEq M]

theorem BookProof.NavierStokesFlow.FockOfFock.ccr_same (m : M) :
    (annih m).comp (creat m) - (creat m).comp (annih m)
      = LinearMap.id (R := ℂ) (M := FockDom M) := by sorry
