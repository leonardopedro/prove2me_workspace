-- Generated from ChapterBRSTNilpotent.lean — solution of BookProof.BRSTNilpotent.chi_swap4
import Mathlib
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.BRSTNilpotent




variable {R : Type*} [Ring R] [Algebra ℝ R]
variable {n : ℕ}

variable {R : Type*} [Ring R] [Algebra ℝ R]
variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (χ β : Fin n → R) (hCAR : GhostCAR χ β) (a b c d : Fin n) :
    χ a * χ b * χ c * χ d = χ c * χ d * χ a * χ b := by

  -- By anticommuting χa past χc and χd, we get another negative sign.
  have h_acd : χ a * (χ c * χ d) = (χ c * χ d) * χ a := by
    have := hCAR.chichi a c;      have := hCAR.chichi a d;      have := hCAR.chichi c d; simp_all [
        mul_assoc, ← eq_sub_iff_add_eq ] ;
    simp_all [ ← mul_assoc ];
    simp_all [ mul_assoc ];
  have h_comm : χ b * (χ c * χ d) = (χ c * χ d) * χ b := by
    simp_all [ ← mul_assoc ];
    have := hCAR.chichi b c;      have := hCAR.chichi b d; simp_all [ mul_assoc,
        add_eq_zero_iff_eq_neg ] ;
  grind
