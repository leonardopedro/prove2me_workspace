-- Generated from ChapterSmCarAlgebra.lean — theorem BookProof.SmCar.sum_apply_fock
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar

variable {n : ℕ}



open Finset


theorem BookProof.SmCar.sum_apply_fock (f : Fin n → FermiFock n) (S : Finset (Fin n)) :
    (∑ i : Fin n, f i) S = ∑ i : Fin n, (f i) S := by sorry
