-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.jwSign_mul_self
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (i : Fin n) (S : Finset (Fin n)) : jwSign i S * jwSign i S = 1 := by

  simp [jwSign, ← pow_add, ← two_mul, pow_mul]
