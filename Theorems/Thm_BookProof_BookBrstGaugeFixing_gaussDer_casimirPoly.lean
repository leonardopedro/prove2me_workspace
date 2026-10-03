-- Generated from ChapterBookBrstGaugeFixing.lean — theorem BookProof.BookBrstGaugeFixing.gaussDer_casimirPoly
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

theorem BookProof.BookBrstGaugeFixing.gaussDer_casimirPoly (hD : ∀ μ c a, G.D μ c a = 0) (c : Fin N) :
    gaussDer G c (casimirPoly (N := N)) = 0 := by sorry
