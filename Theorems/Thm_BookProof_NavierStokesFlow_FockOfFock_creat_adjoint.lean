-- Generated from ChapterNavierStokesFockSpace.lean — theorem BookProof.NavierStokesFlow.FockOfFock.creat_adjoint
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock

variable {ι : Type*}
variable {ι : Type*}
variable {M : Type*} [DecidableEq M]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]




open FullEsa

theorem BookProof.NavierStokesFlow.FockOfFock.creat_adjoint (m : M) (v w : FockDom M) :
    (inner ℂ ((creat m v : FockDom M) : FockL2 M) ((w : FockDom M) : FockL2 M) : ℂ)
      = inner ℂ ((v : FockDom M) : FockL2 M) ((annih m w : FockDom M) : FockL2 M) := by sorry
