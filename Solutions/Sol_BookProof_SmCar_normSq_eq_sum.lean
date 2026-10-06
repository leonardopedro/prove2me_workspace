-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.normSq_eq_sum
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (x : FermiFock n) :
    ‖x‖ ^ 2 = ∑ S : Finset (Fin n), ‖x S‖ ^ 2 := by

  rw [EuclideanSpace.norm_eq, Real.sq_sqrt]
  exact Finset.sum_nonneg fun S _ => by positivity
