-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.inner_eq_sum
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar

variable {n : ℕ}



open Finset


theorem BookProof.SmCar.inner_eq_sum (x y : FermiFock n) :
    (inner ℂ x y : ℂ) = ∑ S : Finset (Fin n), (starRingEnd ℂ) (x S) * y S := by sorry
