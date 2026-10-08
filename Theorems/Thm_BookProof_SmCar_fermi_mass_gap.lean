-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.fermi_mass_gap
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar



open Finset

variable {n : ℕ}


theorem BookProof.SmCar.fermi_mass_gap {m : Fin n → ℝ} {mu : ℝ} (hmu : 0 ≤ mu) (hm : ∀ i, mu ≤ m i)
    (ψ : FermiFock n) (hvac : ψ ∅ = 0) :
    mu * ‖ψ‖ ^ 2 ≤ (inner ℂ ψ (fermiEnergy m ψ) : ℂ).re := by sorry
