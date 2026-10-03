-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.Q_gf_anticomm
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterA4
open BookProof.BRSTNilpotent

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}



open MvPolynomial

noncomputable section

theorem BookProof.BookBrstGaugeFixing.Q_gf_anticomm (hCAR : GhostCAR χ β) (hf12 : ∀ a b c, f a b c = -f b a c)
    (hBχ : ∀ a b, B a * χ b = χ b * B a) (hBβ : ∀ a b, B a * β b = β b * B a) :
    Q f χ β * gfFermion β B + gfFermion β B * Q f χ β
      = ∑ a, ∑ b, ∑ c, (2 * f a b c) • (B a * (χ b * β c)) := by sorry
