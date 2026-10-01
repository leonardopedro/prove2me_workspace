-- Generated from ChapterNavierStokesFockSpace.lean — theorem BookProof.NavierStokesFlow.FockOfFock.coeffOp_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock

variable {ι : Type*}
variable {ι : Type*}
variable {M : Type*} [DecidableEq M]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]




open FullEsa

theorem BookProof.NavierStokesFlow.FockOfFock.coeffOp_coe (T : (ι → ℂ) → ι → ℂ) (hsupp) (hadd) (hsmul) (f : lpFiniteModes ι) :
    (((coeffOp T hsupp hadd hsmul f : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) : ι → ℂ)
      = T ((f : lp (fun _ : ι => ℂ) 2) : ι → ℂ) := by sorry
