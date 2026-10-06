-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.smul_apply_fock
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (c : ℂ) (x : FermiFock n) (S : Finset (Fin n)) :
    (c • x) S = c * x S := rfl
