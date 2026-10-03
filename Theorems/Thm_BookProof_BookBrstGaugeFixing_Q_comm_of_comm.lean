-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.Q_comm_of_comm
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterA4
open BookProof.BRSTNilpotent

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}



open MvPolynomial

noncomputable section

theorem BookProof.BookBrstGaugeFixing.Q_comm_of_comm {T : R} (hχ : ∀ a, χ a * T = T * χ a)
    (hβ : ∀ a, β a * T = T * β a) : Q f χ β * T = T * Q f χ β := by sorry
