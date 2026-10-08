-- Generated from ChapterSmBrstGhost.lean — theorem BookProof.SmBrstGhost.brstCharge_nilpotent
import Definitions.Def_ChapterSmCarAlgebra
import Definitions.Def_ChapterYangMillsSU3
import Mathlib
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.BRSTNilpotent
open BookProof.SmBrstGhost



open BookProof.SmCar BookProof.BRSTNilpotent BookProof.YangMillsSU3

noncomputable section

variable {m : ℕ}
variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}

theorem BookProof.SmBrstGhost.brstCharge_nilpotent (f : Fin n → Fin n → Fin n → ℝ) (χ β G : Fin n → R)
    (hCAR : GhostCAR χ β)
    (hGχ : ∀ a b, G a * χ b = χ b * G a) (hGβ : ∀ a b, G a * β b = β b * G a)
    (hclose : ∀ a b, G a * G b - G b * G a = ∑ c, f a b c • G c)
    (hf12 : ∀ a b c, f a b c = -f b a c)
    (hjac : ∀ a b c h : Fin n,
      ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0) :
    brstCharge f χ β G * brstCharge f χ β G = 0 := by sorry
