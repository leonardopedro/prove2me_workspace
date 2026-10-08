-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.fermiEnergy_apply
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar



open Finset

variable {n : ℕ}


theorem BookProof.SmCar.fermiEnergy_apply (m : Fin n → ℝ) (ψ : FermiFock n) (S : Finset (Fin n)) :
    (fermiEnergy m ψ) S = ((∑ i ∈ S, m i : ℝ) : ℂ) * ψ S := by sorry
