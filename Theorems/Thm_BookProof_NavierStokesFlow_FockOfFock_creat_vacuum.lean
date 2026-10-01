-- Generated from ChapterNavierStokesFockSpace.lean — theorem BookProof.NavierStokesFlow.FockOfFock.creat_vacuum
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock

variable {ι : Type*}
variable {ι : Type*}
variable {M : Type*} [DecidableEq M]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]




open FullEsa

theorem BookProof.NavierStokesFlow.FockOfFock.creat_vacuum (m : M) :
    creat m (vacuum : FockDom M) = fockBasis (Finsupp.single m 1) := by sorry
