-- Generated from ChapterNavierStokesFockSpace.lean — solution of BookProof.NavierStokesFlow.FockOfFock.add_single_sub_single
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock





open FullEsa

set_option maxHeartbeats 1000000 in
theorem solution (m : M) (n : Conf M) :
    (n + Finsupp.single m 1 : Conf M) - Finsupp.single m 1 = n := by

  ext j
  rcases eq_or_ne j m with rfl | hj
  · simp
  · simp
