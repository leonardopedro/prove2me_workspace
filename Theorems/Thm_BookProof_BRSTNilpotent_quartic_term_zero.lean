-- Generated from ChapterBRSTNilpotent.lean — theorem BookProof.BRSTNilpotent.quartic_term_zero
import Mathlib
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.BRSTNilpotent

variable {R : Type*} [Ring R] [Algebra ℝ R]
variable {n : ℕ}




theorem BookProof.BRSTNilpotent.quartic_term_zero (f : Fin n → Fin n → Fin n → ℝ) (χ β : Fin n → R)
    (hCAR : GhostCAR χ β) :
    (∑ a, ∑ b, ∑ e, ∑ d, ∑ g, ∑ h,
      (f a b e * f d g h) • (χ a * χ b * χ d * χ g * β e * β h)) = 0 := by sorry
