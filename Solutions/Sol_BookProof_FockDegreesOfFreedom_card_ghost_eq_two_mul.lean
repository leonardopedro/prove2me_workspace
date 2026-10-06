-- Generated from ChapterFockDegreesOfFreedom.lean — solution of BookProof.FockDegreesOfFreedom.card_ghost_eq_two_mul
import Mathlib
import Definitions.Def_ChapterFockDegreesOfFreedom
open BookProof.FockDegreesOfFreedom




open Fintype

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) :
    Fintype.card (Fin (k + 1) → ZMod 2) = 2 * Fintype.card (Fin k → ZMod 2) := by

  simp [pow_succ, Nat.mul_comm]
