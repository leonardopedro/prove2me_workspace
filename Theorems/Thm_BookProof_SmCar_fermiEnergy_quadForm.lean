-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.fermiEnergy_quadForm
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar



open Finset

variable {n : ℕ}


theorem BookProof.SmCar.fermiEnergy_quadForm (m : Fin n → ℝ) (ψ : FermiFock n) :
    (inner ℂ ψ (fermiEnergy m ψ) : ℂ)
      = ∑ S : Finset (Fin n), ((∑ i ∈ S, m i : ℝ) : ℂ) * ((‖ψ S‖ ^ 2 : ℝ) : ℂ) := by sorry
