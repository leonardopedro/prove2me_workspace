-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.car_creat_creat
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar



open Finset

variable {n : ℕ}


theorem BookProof.SmCar.car_creat_creat (i j : Fin n) :
    creat i ∘ₗ creat j + creat j ∘ₗ creat i = 0 := by sorry
