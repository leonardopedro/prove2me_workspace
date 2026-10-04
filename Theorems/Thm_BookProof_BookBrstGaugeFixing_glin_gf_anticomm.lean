-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.glin_gf_anticomm
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterA4
open BookProof.BRSTNilpotent
open BookProof.BookBrstGaugeFixing

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}



open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

theorem BookProof.BookBrstGaugeFixing.glin_gf_anticomm (hCAR : GhostCAR χ β)
    (hGβ : ∀ a b, Gc a * β b = β b * Gc a)
    (hBχ : ∀ a b, B a * χ b = χ b * B a) (hBβ : ∀ a b, B a * β b = β b * B a) :
    glin Gc χ * gfFermion β B + gfFermion β B * glin Gc χ
      = (∑ c, Gc c * B c) - ∑ c, ∑ d, (Gc c * B d - B d * Gc c) * (β d * χ c) := by sorry
