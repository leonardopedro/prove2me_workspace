-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.brstCharge_comm_of_comm
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterSmBrstGhost
import Definitions.Def_ChapterA4
open BookProof.BRSTNilpotent
open BookProof.SmBrstGhost

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}



open MvPolynomial

noncomputable section

theorem BookProof.BookBrstGaugeFixing.brstCharge_comm_of_comm {T : R} (hG : ∀ a, Gc a * T = T * Gc a)
    (hχ : ∀ a, χ a * T = T * χ a) (hβ : ∀ a, β a * T = T * β a) :
    brstCharge f Gc χ β * T = T * brstCharge f Gc χ β := by sorry
