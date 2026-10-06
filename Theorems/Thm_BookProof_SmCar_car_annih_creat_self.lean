-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.car_annih_creat_self
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar

variable {n : ℕ}



open Finset


theorem BookProof.SmCar.car_annih_creat_self (i : Fin n) :
    annih i ∘ₗ creat i + creat i ∘ₗ annih i = LinearMap.id := by sorry
