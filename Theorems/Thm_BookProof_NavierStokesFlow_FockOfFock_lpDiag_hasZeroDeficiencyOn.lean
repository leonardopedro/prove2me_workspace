-- Generated from ChapterNavierStokesFockSpace.lean — theorem BookProof.NavierStokesFlow.FockOfFock.lpDiag_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock

variable {ι : Type*}
variable {ι : Type*}
variable {M : Type*} [DecidableEq M]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]




open FullEsa

theorem BookProof.NavierStokesFlow.FockOfFock.lpDiag_hasZeroDeficiencyOn (c : ι → ℝ) :
    HasZeroDeficiencyOn (lpFiniteModes ι) (lpDiag c) := by sorry
