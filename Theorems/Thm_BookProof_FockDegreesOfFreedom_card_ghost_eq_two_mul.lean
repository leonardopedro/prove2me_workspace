-- Generated from ChapterFockDegreesOfFreedom.lean — theorem BookProof.FockDegreesOfFreedom.card_ghost_eq_two_mul
import Mathlib
import Definitions.Def_ChapterFockDegreesOfFreedom
open BookProof.FockDegreesOfFreedom



open Fintype

theorem BookProof.FockDegreesOfFreedom.card_ghost_eq_two_mul (k : ℕ) :
    Fintype.card (Fin (k + 1) → ZMod 2) = 2 * Fintype.card (Fin k → ZMod 2) := by sorry
