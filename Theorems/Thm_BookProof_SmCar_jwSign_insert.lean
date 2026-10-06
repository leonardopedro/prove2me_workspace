-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.jwSign_insert
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar

variable {n : ℕ}



open Finset


theorem BookProof.SmCar.jwSign_insert {i j : Fin n} {S : Finset (Fin n)} (hj : j ∉ S) :
    jwSign i (insert j S) = (if j < i then -1 else 1) * jwSign i S := by sorry
