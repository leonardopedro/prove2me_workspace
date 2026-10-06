-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.fermiEnergy_occ
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar

variable {n : ℕ}



open Finset


theorem BookProof.SmCar.fermiEnergy_occ (m : Fin n → ℝ) (S : Finset (Fin n)) :
    fermiEnergy m (occ S) = ((∑ i ∈ S, m i : ℝ) : ℂ) • occ S := by sorry
