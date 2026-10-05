-- Generated from ChapterBRSTNilpotent.lean — theorem BookProof.BRSTNilpotent.contracted_terms_zero
import Mathlib
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.BRSTNilpotent

variable {R : Type*} [Ring R] [Algebra ℝ R]
variable {n : ℕ}




theorem BookProof.BRSTNilpotent.contracted_terms_zero (f : Fin n → Fin n → Fin n → ℝ) (χ β : Fin n → R)
    (hCAR : GhostCAR χ β)
    (hjac : ∀ a b c h : Fin n,
      ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0) :
    (∑ a, ∑ b, ∑ e, ∑ g, ∑ h,
      (f a b e * f e g h) • (χ a * χ b * χ g * β h)) = 0 := by sorry
