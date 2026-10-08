-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.inner_eq_sum
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar



open Finset

variable {n : ℕ}


theorem BookProof.SmCar.inner_eq_sum (x y : FermiFock n) :
    (inner ℂ x y : ℂ) = ∑ S : Finset (Fin n), (starRingEnd ℂ) (x S) * y S := by sorry
