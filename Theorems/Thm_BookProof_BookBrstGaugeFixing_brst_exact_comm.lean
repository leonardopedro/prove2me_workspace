-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.brst_exact_comm
import Definitions.Def_ChapterBRSTNilpotent
import Mathlib
import Definitions.Def_ChapterBookBrstGaugeFixing
import Definitions.Def_ChapterA4

variable {R : Type*} [Ring R] [Algebra ℝ R] {n : ℕ}
variable {f : Fin n → Fin n → Fin n → ℝ} {Gc χ β B : Fin n → R}



open MvPolynomial

noncomputable section

theorem BookProof.BookBrstGaugeFixing.brst_exact_comm {Ω Ψ : R} (hnil : Ω * Ω = 0) :
    Ω * (Ω * Ψ + Ψ * Ω) = (Ω * Ψ + Ψ * Ω) * Ω := by sorry
