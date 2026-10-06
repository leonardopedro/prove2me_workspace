-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.sum_apply_fock
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (f : Fin n → FermiFock n) (S : Finset (Fin n)) :
    (∑ i : Fin n, f i) S = ∑ i : Fin n, (f i) S := by

  simp [WithLp.ofLp_sum]
