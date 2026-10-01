-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.fockDom_ne_top
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_lpFiniteModes_ne_top
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock





open FullEsa

set_option maxHeartbeats 1000000 in
theorem solution [Nonempty M] :
    (FockDom M : Submodule ℂ (FockL2 M)) ≠ ⊤ := lpFiniteModes_ne_top (Conf M)
