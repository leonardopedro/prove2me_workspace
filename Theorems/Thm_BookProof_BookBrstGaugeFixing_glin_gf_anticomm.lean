-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.glin_gf_anticomm
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterBookBrstYangMills
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.BRSTNilpotent
open BookProof.BookBrstGaugeFixing



open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}

theorem BookProof.BookBrstGaugeFixing.glin_gf_anticomm (hCAR : GhostCAR χ β)
    (hGβ : ∀ a b, Gc a * β b = β b * Gc a)
    (hBχ : ∀ a b, B a * χ b = χ b * B a) (hBβ : ∀ a b, B a * β b = β b * B a) :
    glin Gc χ * gfFermion β B + gfFermion β B * glin Gc χ
      = (∑ c, Gc c * B c) - ∑ c, ∑ d, (Gc c * B d - B d * Gc c) * (β d * χ c) := by sorry
