-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.glin_comm_of_comm
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterA4

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}
variable {N : ℕ} (G : GaugeAlgebra N)
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β : Fin n → R}



open MvPolynomial

noncomputable section

theorem BookProof.BookBrstGaugeFixing.glin_comm_of_comm {T : R} (hG : ∀ a, Gc a * T = T * Gc a)
    (hχ : ∀ a, χ a * T = T * χ a) : glin Gc χ * T = T * glin Gc χ := by sorry
