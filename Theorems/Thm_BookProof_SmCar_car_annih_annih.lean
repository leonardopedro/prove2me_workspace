-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.car_annih_annih
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterNavierStokesFockSpace
open BookProof.NavierStokesFlow.FockOfFock
open BookProof.SmCar



open Finset

variable {n : ℕ}


theorem BookProof.SmCar.car_annih_annih (i j : Fin n) :
    annih i ∘ₗ annih j + annih j ∘ₗ annih i = 0 := by sorry
