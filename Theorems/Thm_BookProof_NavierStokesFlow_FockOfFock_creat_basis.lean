-- Generated from ChapterNavierStokesFockSpace.lean — theorem BookProof.NavierStokesFlow.FockOfFock.creat_basis
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.NavierStokesFlow.FullEsa
variable {ι : Type*}














variable {ι : Type*}











variable {M : Type*} [DecidableEq M]

theorem BookProof.NavierStokesFlow.FockOfFock.creat_basis (m : M) (n : Conf M) :
    creat m (fockBasis n)
      = ((Real.sqrt (n m + 1) : ℝ) : ℂ) • fockBasis (n + Finsupp.single m 1) := by sorry
