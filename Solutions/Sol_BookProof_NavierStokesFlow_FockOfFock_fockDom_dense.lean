-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.fockDom_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesFullEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock









open BookProof.NavierStokesFlow.FullEsa



variable {ι : Type*}














variable {ι : Type*}











variable {M : Type*} [DecidableEq M]

set_option maxHeartbeats 1000000 in
theorem solution : Dense ((FockDom M : Submodule ℂ (FockL2 M)) : Set (FockL2 M)) := lpFiniteModes_dense
