-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.car_annih_creat_of_ne
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar



open Finset

variable {n : ℕ}


theorem BookProof.SmCar.car_annih_creat_of_ne {i j : Fin n} (hij : i ≠ j) :
    annih i ∘ₗ creat j + creat j ∘ₗ annih i = 0 := by sorry
