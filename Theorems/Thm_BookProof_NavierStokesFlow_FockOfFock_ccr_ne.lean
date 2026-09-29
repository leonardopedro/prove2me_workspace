-- Generated from ChapterNavierStokesFockSpace.lean — theorem BookProof.NavierStokesFlow.FockOfFock.ccr_ne
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.NavierStokesFlow.FullEsa
variable {ι : Type*}














variable {ι : Type*}











variable {M : Type*} [DecidableEq M]

theorem BookProof.NavierStokesFlow.FockOfFock.ccr_ne {m m' : M} (h : m ≠ m') :
    (annih m).comp (creat m') - (creat m').comp (annih m) = 0 := by sorry
