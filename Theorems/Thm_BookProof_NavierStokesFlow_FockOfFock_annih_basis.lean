-- Generated from ChapterNavierStokesFockSpace.lean — theorem BookProof.NavierStokesFlow.FockOfFock.annih_basis
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock








open FullEsa



variable {ι : Type*}














variable {ι : Type*}











variable {M : Type*} [DecidableEq M]

theorem BookProof.NavierStokesFlow.FockOfFock.annih_basis (m : M) (n : Conf M) :
    annih m (fockBasis n) = ((Real.sqrt (n m) : ℝ) : ℂ) • fockBasis (n - Finsupp.single m 1) := by sorry
