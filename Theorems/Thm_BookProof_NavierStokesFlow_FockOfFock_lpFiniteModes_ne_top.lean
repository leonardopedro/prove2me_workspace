-- Generated from ChapterNavierStokesFockSpace.lean — theorem BookProof.NavierStokesFlow.FockOfFock.lpFiniteModes_ne_top
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock

variable {ι : Type*}
variable {ι : Type*}
variable {M : Type*} [DecidableEq M]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]




open FullEsa

theorem BookProof.NavierStokesFlow.FockOfFock.lpFiniteModes_ne_top (ι : Type*) [Infinite ι] :
    lpFiniteModes ι ≠ (⊤ : Submodule ℂ (lp (fun _ : ι => ℂ) 2)) := by sorry
