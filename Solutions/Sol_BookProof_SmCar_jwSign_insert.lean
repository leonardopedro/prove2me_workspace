-- Generated from ChapterSmCarAlgebra.lean — solution of BookProof.SmCar.jwSign_insert
import Mathlib
import Definitions.Def_ChapterSmCarAlgebra
open BookProof.SmCar




open Finset

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {i j : Fin n} {S : Finset (Fin n)} (hj : j ∉ S) :
    jwSign i (insert j S) = (if j < i then -1 else 1) * jwSign i S := by

  by_cases h : j < i
  · have hnot : j ∉ S.filter (fun k => k < i) := fun hmem => hj (Finset.mem_filter.mp hmem).1
    rw [jwSign, jwSign, Finset.filter_insert, if_pos h, Finset.card_insert_of_notMem hnot,
      if_pos h]
    ring
  · rw [jwSign, jwSign, Finset.filter_insert, if_neg h, if_neg h, one_mul]
