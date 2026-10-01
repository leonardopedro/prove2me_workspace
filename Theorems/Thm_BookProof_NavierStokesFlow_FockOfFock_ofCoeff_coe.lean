-- Generated from ChapterNavierStokesFockSpace.lean — theorem BookProof.NavierStokesFlow.FockOfFock.ofCoeff_coe
import Mathlib
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.FockOfFock

variable {ι : Type*}
variable {ι : Type*}
variable {M : Type*} [DecidableEq M]
variable {J K : Type*} [DecidableEq J] [DecidableEq K]




open FullEsa

theorem BookProof.NavierStokesFlow.FockOfFock.ofCoeff_coe (φ : ι → ℂ) (h : (Function.support φ).Finite) :
    (((ofCoeff φ h : lpFiniteModes ι) : lp (fun _ : ι => ℂ) 2) : ι → ℂ) = φ := by sorry
