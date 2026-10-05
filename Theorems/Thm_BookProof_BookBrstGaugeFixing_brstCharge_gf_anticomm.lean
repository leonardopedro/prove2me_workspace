-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.brstCharge_gf_anticomm
import Definitions.Def_ChapterQuantumGravityBrstCharge
import Definitions.Def_ChapterBookBrstYangMills
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterSmBrstGhost
open BookProof.BRSTNilpotent
open BookProof.SmBrstGhost
open BookProof.BookBrstGaugeFixing

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}



open BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge BookProof.BookBrstYangMills
open MvPolynomial

noncomputable section

theorem BookProof.BookBrstGaugeFixing.brstCharge_gf_anticomm (hCAR : GhostCAR χ β) (hf12 : ∀ a b c, f a b c = -f b a c)
    (hGβ : ∀ a b, Gc a * β b = β b * Gc a)
    (hBχ : ∀ a b, B a * χ b = χ b * B a) (hBβ : ∀ a b, B a * β b = β b * B a) :
    brstCharge f Gc χ β * gfFermion β B + gfFermion β B * brstCharge f Gc χ β
      = (∑ c, Gc c * B c)
        - (∑ c, ∑ d, (Gc c * B d - B d * Gc c) * (β d * χ c))
        - ∑ a, ∑ b, ∑ c, f a b c • (B a * (χ b * β c)) := by sorry
