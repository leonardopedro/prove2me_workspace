-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.fermiEnergy_eq_sum
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar



open Finset

variable {n : ℕ}


theorem BookProof.SmCar.fermiEnergy_eq_sum (m : Fin n → ℝ) (ψ : FermiFock n) :
    fermiEnergy m ψ = ∑ i : Fin n, (m i : ℂ) • creat i (annih i ψ) := by sorry
