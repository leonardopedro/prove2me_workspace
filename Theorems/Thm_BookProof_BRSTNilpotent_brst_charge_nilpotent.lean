-- Generated from ChapterBRSTNilpotent.lean — theorem BookProof.BRSTNilpotent.brst_charge_nilpotent
import Mathlib
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.BRSTNilpotent



variable {R : Type*} [Ring R] [Algebra ℝ R]
variable {n : ℕ}


theorem BookProof.BRSTNilpotent.brst_charge_nilpotent (f : Fin n → Fin n → Fin n → ℝ) (χ β : Fin n → R)
    (hCAR : GhostCAR χ β)
    (hf12 : ∀ a b c, f a b c = -f b a c)
    (hjac : ∀ a b c h : Fin n,
      ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0) :
    Q f χ β * Q f χ β = 0 := by sorry
