-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.normSq_eq_sum
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar



open Finset

variable {n : ℕ}


theorem BookProof.SmCar.normSq_eq_sum (x : FermiFock n) :
    ‖x‖ ^ 2 = ∑ S : Finset (Fin n), ‖x S‖ ^ 2 := by sorry
