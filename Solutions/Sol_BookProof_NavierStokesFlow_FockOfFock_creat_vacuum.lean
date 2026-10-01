-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.creat_vacuum
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
import Theorems.Thm_BookProof_NavierStokesFlow_FockOfFock_creat_basis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock





open FullEsa

set_option maxHeartbeats 1000000 in
theorem solution (m : M) :
    creat m (vacuum : FockDom M) = fockBasis (Finsupp.single m 1) := by

  rw [vacuum, creat_basis]
  simp
