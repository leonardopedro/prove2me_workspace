-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.fockDom_dense
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock





open FullEsa

set_option maxHeartbeats 1000000 in
theorem solution : Dense ((FockDom M : Submodule ℂ (FockL2 M)) : Set (FockL2 M)) := lpFiniteModes_dense
