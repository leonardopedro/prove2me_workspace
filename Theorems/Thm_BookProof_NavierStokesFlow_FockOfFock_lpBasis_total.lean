-- Generated from ChapterNavierStokesFockSpace.lean — theorem BookProof.NavierStokesFlow.FockOfFock.lpBasis_total
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock

variable {ι : Type*}
variable {ι : Type*}
variable {M : Type*} [DecidableEq M]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]




open FullEsa

theorem BookProof.NavierStokesFlow.FockOfFock.lpBasis_total [DecidableEq ι] (w : lp (fun _ : ι => ℂ) 2)
    (hw : ∀ i, (inner ℂ ((lpBasis i : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) w : ℂ) = 0) :
    w = 0 := by sorry
